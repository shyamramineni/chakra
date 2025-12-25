// JavaScript Document
var quotation = {};
quotation.temp = {};
var quotationEventHandlers = {
	customerSelected: function(data) {
		quotation.customer = data.toJSON();
		quotation.customerId = quotation.customer.id;
		if(quotation.sourcePage == "Enquiry") {
			quotation.specsTile = new QuotationSpecsTile({container: "#quotation_info_tile_init"});
			quotation.specsTile.registerEventHandler("event_submitBtnClicked", this.quotationSpecsSubmitClick, this);
		}
		else if(quotation.sourcePage == "QuotationPlanner") {
			var req = {};
			req.customerId = quotation.customerId;
			req.quotSpecs = $.parseJSON($("#quotation_planner_specs").val());
			req.quotInfo = $.parseJSON($("#quotation_planner_quotinfo").val());
			req.modelInfo = $.parseJSON($("#quotation_planner_modelinfo").val());
			var reqdata = "requestType=QuotationPlannerInfoSubmitRequest&requestData=" + JSON.stringify(req);
			var request = new ServerRequest({requrl: $("#quotation_planner_info_submit_request-url").val(), requestType: "QuotationPlannerInfoSubmitRequest"});
			request.sendRequestAndNotify(reqdata, quotation.serverResponseHandler, quotation);
		}
		else {
			//quotation.createQuotationInfoTile();
			var quotCartInfo = $.parseJSON($("#quotation_cart_info").val());
			quotCartInfo.customerId = quotation.customerId;
			var sreq = new ServerRequest({requrl: $("#quotation_cart_info_submit_request-url").val(), requestType: "QuotationCartInfoSubmitRequest"});
			var req = "requestType=QuotationCartInfoSubmitRequest&requestData=" + JSON.stringify(quotCartInfo);
			sreq.sendRequestAndNotify(req, quotation.serverResponseHandler, quotation);
		}
	},
	quotationSpecsSubmitClick: function(specs) {
		quotation.specs = specs;
		quotation.specs.customerId = quotation.customerId;
		quotation.specs.enquiryId = quotation.enquiryId;
		var sreq = new ServerRequest({requrl: $("#specs_submit-url").val(), requestType: "QuotationSubmitRequest"});
		var reqData = "requestType=QuotationSubmitRequest&requestData="+JSON.stringify(quotation.specs);
		sreq.sendRequestAndNotify(reqData, quotation.serverResponseHandler, this);
	},
	modelAddbtnClickHandler: function() {
		$("body").append('<div id="model_add_popup_container"></div>');
		quotation.popup = new ModelAddPopup({container: "#model_add_popup_container"});
		quotation.popup.registerEventHandler("event_submitBtnClicked", this.modelAddPopupSubmitBtnClickedHandler, this);
		quotation.popup.registerEventHandler("event_cancelBtnClicked", this.modelAddPopupCancelBtnClickedHandler, this);
		quotation.popup.registerEventHandler("event_cagePartSpecRequest", this.modelAddPopupCagePartSpecRequestHandler, this);
	},
	modelRowClickHandler: function(modelId) {
		console.log("modelId: "+modelId)
		quotation.modelInfo.selectModel(modelId);
	},
	modelConfirmBtnClickHandler: function(form) {
		$(form).children("input.quot-id").eq(0).attr("value", quotation.quotationId);
		$(form).children("input.quot-model-id").eq(0).attr("value",$(form).parents(".model-grid-row-data").attr("name"));
		$(form).submit();
	},
	modelPrintBtnClickHandler: function(form) {
		$(form).children("input.quot-id").eq(0).attr("value", quotation.quotationId);
		$(form).children("input.quot-model-id").eq(0).attr("value",$(form).parents(".model-grid-row-data").attr("name"));
		$(form).submit();
	},
	modelAddPopupCagePartSpecRequestHandler: function(data) {
		quotation.temp.cagePartSpecs = data;
	},
	modelAddPopupSubmitBtnClickedHandler: function(modelAddRequest) {
		var reqdata = modelAddRequest.getModelAddRequestData(quotation.quotationId, quotation.taxVal);
		var req="requestType=QuotationModelAddRequest&requestData="+JSON.stringify(reqdata);
		quotation.temp.cagePartTypes = reqdata.cagePartTypes;
		var reqObj = new ServerRequest({requrl: $("#modeladd-url").val(), "requestType" :"QuotationModelAddRequest"});
		reqObj.sendRequestAndNotify(req, quotation.serverResponseHandler, this);
	},	
	modelAddPopupCancelBtnClickedHandler: function() {
		//$("#model_add-btn").removeAttr("disabled");
		quotation.modelGrid.enableModelAddBtn();
	},
	quotationTaxSelected: function(taxdata) {
		quotation.taxVal = taxdata.taxVal;
		quotation.taxName = taxdata.taxName;
		quotation.initModelsBlock();		
	},
	modelInfoEdited: function(data) {
		data.reqData.quotationId = quotation.quotationId;
		var reqData = "requestType="+data.requestType+"&requestData="+JSON.stringify(data.reqData);
		var sreq = new ServerRequest({requrl: data.requestUrl, requestType: "ModelInfoUpdateRequest"});
		sreq.sendRequestAndNotify(reqData, quotation.serverResponseHandler, quotation);
	},
	modelInfoTabSelected: function(modelId) {
		quotation.modelGrid.selectQuotationModel(modelId);
	}
};

quotation.initModelsBlock = function() {
	quotation.modelGrid = new QuotationModelGrid({container: "#models_tile"});
	quotation.modelGrid.registerEventHandler("event_addModelAddBtnClicked", quotationEventHandlers.modelAddbtnClickHandler, quotationEventHandlers);
	quotation.modelGrid.registerEventHandler("event_clickModelRow", quotationEventHandlers.modelRowClickHandler, quotationEventHandlers);
	quotation.modelGrid.registerEventHandler("event_confirmBtnClicked", quotationEventHandlers.modelConfirmBtnClickHandler, quotationEventHandlers);
	quotation.modelGrid.registerEventHandler("event_printBtnClicked", quotationEventHandlers.modelPrintBtnClickHandler, quotationEventHandlers);
	
	quotation.modelInfo = new QuotationModelInfo({container: "#models_info_tile"});
	quotation.modelInfo.registerEventHandler("ModelInfoEdited", quotationEventHandlers.modelInfoEdited, quotationEventHandlers);
	quotation.modelInfo.registerEventHandler("ModelInfoTabSelected", quotationEventHandlers.modelInfoTabSelected, quotationEventHandlers);
}

quotation.createQuotationInfoTile = function() {
	quotation.quotInfo = new QuotationInfoTile({container: "#quotation_info_tile"});
	if(quotation.sourcePage == "Enquiry" && quotation.startMode == "Normal") {
		quotation.quotInfo.showQuotInfo(quotation.quotationInfo, true);
	}
	else if(quotation.startMode == "Loader" || quotation.sourcePage == "QuotationPlanner" || quotation.sourcePage == "QuotationCart") {
		if(quotation.taxVal) {
			quotation.quotationInfo.taxation = quotation.taxName;
			quotation.quotInfo.showQuotInfo(quotation.quotationInfo);
		}
		else {
			quotation.quotInfo.showQuotInfo(quotation.quotationInfo, true);
		}
	}
	quotation.quotInfo.registerEventHandler("TaxSelected", quotationEventHandlers.quotationTaxSelected, quotationEventHandlers);
	
	// for enquiry, model tiles are created after selecting tax
	if(quotation.sourcePage != "Enquiry" || ( quotation.startMode == "Loader" && quotation.taxVal )) {
		quotation.initModelsBlock();
	}
}

quotation.serverResponseHandler = function(respType, jqXHR) {
	console.log("int serverResponseHandler: "+respType);
	switch(respType)
	{
		case "QuotationSubmitRequest":
		{
			var json = $.parseJSON(jqXHR.responseText);
			quotation.quotationInfo = json.responseData;
			//quotation.quotationInfo.enquiry = quotation.enquiryId;
			//json.responseData.taxation = "1";
			quotation.quotationId = json.responseData.id;
			
			quotation.specsTile.showSpecs(quotation.specs);
			quotation.createQuotationInfoTile();
			
		}
		break;
		case "QuotationModelAddRequest":
		{
			var obj = $.parseJSON(jqXHR.responseText);
			var model = new QuotationModel(obj.responseData.model);
			quotation.modelGrid.addQuotationModel(model, quotation.temp.cagePartTypes);
			quotation.modelGrid.enableModelAddBtn();
			
			var infoModel = new ModelWithInfo(obj.responseData.model);
			infoModel.set('modelInfo', obj.responseData.modelInfo);
			quotation.modelInfo.addModel(infoModel);
		}
		break;
		case "CustomerFetchRequest":
		{
			quotation.customer = $.parseJSON(jqXHR.responseText).responseData;
			if(quotation.sourcePage == "Enquiry")
			{
				console.log(quotation.customer);
				quotation.customerTile.setCustomer(quotation.customer);
				quotationEventHandlers.customerSelected(new Customer(quotation.customer));
			}
		}
		break;
		case "ModelInfoUpdateRequest":
		{
			var json = $.parseJSON(jqXHR.responseText);
			var model = quotation.modelInfo.getModel(json.responseData.model.id);
			model.set(json.responseData.model);
			quotation.modelGrid.updateQuotationModel(model);
			var info = model.get('modelInfo');
			
			switch(json.responseCode)
			{
				case "CAGEOK":
				{
					/*var html = _.template($("#cage_part_contents_template").html(), json.responseData);
					html = $(html);
					console.log(html);
					$(elem).children(".collapse-panel-header").html($(html).eq(0).html());
					$(elem).children(".collapse-panel-body").html($(html).eq(2).html());*/
					info.cagePartsDetails = json.responseData.cagePartsDetails;
					model.set('modelInfo', info);
					quotation.modelInfo.updateModel(model);
				}
				break;
				case "MESHOK":
				{
					info.meshPartsDetails = json.responseData.meshPartsDetails;
					model.set('modelInfo', info);
					quotation.modelInfo.updateModel(model);
				}
				break;
				case "CHAINOK":
				{
					info.chainLinkDetails = json.responseData.chainLinkDetails;
					model.set('modelInfo', info);
					quotation.modelInfo.updateModel(model);
				}
				break;
				case "WELDOK":
				{
					info.weldSideDetails = json.responseData.weldSideDetails;
					model.set('modelInfo', info);
					quotation.modelInfo.updateModel(model);
				}
				break;
			}
		}
		break;
		case "QuotationCartInfoSubmitRequest":
		{
			var json = $.parseJSON(jqXHR.responseText);
			quotation.quotationInfo = json.responseData.quotationInfo;
			quotation.quotationId = json.responseData.quotationId;
			quotation.createQuotationInfoTile();
			
			// add model
			json.responseData.model.cageDesign = null;	// to compensate for the lack of cageDesign in quotationCart mode
			var model = new QuotationModel(json.responseData.model);
			model.set('modelInfo',json.responseData.modelInfo);
			quotation.modelGrid.addQuotationModel(model);
			quotation.modelInfo.addModel(model);
			
			quotation.modelGrid.disableModelAddBtn();
			quotation.modelInfo.disableEditFunctionality();
		}
		break;
		case "QuotationPlannerInfoSubmitRequest":
		{
			var json = $.parseJSON(jqXHR.responseText);
			quotation.quotationInfo = json.responseData.quotationInfo;
			quotation.quotationId = json.responseData.quotationInfo.id;
			quotation.quotationSpecs = json.responseData.quotationSpecs;
			quotation.quotationInfo.enquiry = ""; // fix for html element error
			
			// creating specs tile
			quotation.specsTile = new QuotationSpecsTile({container: "#quotation_info_tile_init"});
			quotation.specsTile.showSpecs(quotation.quotationSpecs);
			quotation.createQuotationInfoTile();
			
			// add model
			var model = new ModelWithInfo(json.responseData.quotationModel.model);
			model.set('modelInfo',json.responseData.quotationModel.modelInfo);
			quotation.modelGrid.addQuotationModel(model);
			quotation.modelInfo.addModel(model);
		}
		break;
		case "QuotationLoaderRequest":
		{
			var resp = $.parseJSON(jqXHR.responseText);
			resp = resp.responseData;
			quotation.quotationId = resp.quotInfo.id;
			quotation.quotationMode = "Loader";
			if(resp.quotInfo.enquiry != "")
			{
				quotation.sourcePage = "Enquiry";
			}
			else if(! resp.specsInfo)
			{
				quotation.sourcePage = "QuotationCart";
			}
			else
			{
				quotation.sourcePage = "QuotationPlanner";
			}
			console.log("Source Page: "+ quotation.sourcePage);
			
			quotation.quotationInfo = resp.quotInfo;
			
			//customer tile creation
			quotation.customerTile = new CustomerTile({container: "#customer_tile"});
			quotation.customer = resp.custInfo;
			quotation.customerTile.setCustomer(quotation.customer);
			
			//specs tile creation
			quotation.quotationSpecs = resp.specsInfo;
			quotation.specsTile = new QuotationSpecsTile({container: "#quotation_info_tile_init"});
			quotation.specsTile.showSpecs(quotation.quotationSpecs);
			if (resp.taxation) {
				quotation.taxVal = resp.taxation;
				var sel = $("<select>"+$("#taxation_options_template").html()+"</select>");
				quotation.taxName = $(sel).children("option[value="+quotation.taxVal+"]").text();
			} 
			// quotation info tile creation
			quotation.createQuotationInfoTile();
			
			if(quotation.quotationInfo.status == 'REALIZED')
				quotation.modelGrid.hideConfirmButton();
			
			if(resp.taxation) {	
				// model tiles created in "createQuotationInfoTile" call
				// add models
				for(var m in resp.quotationModels) {
					var model = new ModelWithInfo(resp.quotationModels[m].model);
					model.set('modelInfo',resp.quotationModels[m].modelInfo);
					quotation.modelGrid.addQuotationModel(model);
					quotation.modelInfo.addModel(model);
				}
			}
		}
		break;
	}
}

var Loader = Backbone.Router.extend({
	routes: {
		"qid/:id":"startLoaded",
		"*path":"startNormal"
	},
	startNormal: function(path) {
		quotation.startMode = "Normal";
		quotation.taxVal = $("#quot_plan_taxation").val();
		if($("#quotation_cart_info").val())
		{
			console.log("Source Page: QuotationCart");
			quotation.sourcePage = "QuotationCart";
			quotation.taxVal = $("#quot_plan_taxation").val();
			var sel = $("<select>"+$("#taxation_options_template").html()+"</select>");
			quotation.taxName = $(sel).children("option[value="+quotation.taxVal+"]").text();
		}
		else if($("#quotation_planner_specs").val())
		{
			console.log("Source Page: QuotationPlanner");
			quotation.sourcePage = "QuotationPlanner";
			quotation.taxVal = $("#quot_plan_taxation").val();
			
			var sel = $("<select>"+$("#taxation_options_template").html()+"</select>");
			quotation.taxName = $(sel).children("option[value="+quotation.taxVal+"]").text();
		}
		else if($("#enquiry").val())
		{
			console.log("Source Page: Enquiry");
			quotation.sourcePage = "Enquiry";
			quotation.customerId = $("#customer_id").val();
			quotation.enquiryId = $("#enquiry").val();
		}
		
		//this.quotation = new Quotation();
		quotation.customerTile = new CustomerTile({container: "#customer_tile"});
		quotation.customerTile.registerEventHandler("CustomerSelected", quotationEventHandlers.customerSelected, quotationEventHandlers);
		if(quotation.startMode != "Loader" && quotation.sourcePage == "Enquiry")
		{
			var sreq = new ServerRequest({requrl: $("#customer_fetch-url").val(), "requestType": "CustomerFetchRequest"});
			var req = { customerId: quotation.customerId };
			var data = "requestType=CustomerFetchRequest&requestData=" + JSON.stringify(req);
			sreq.sendRequestAndNotify(data, quotation.serverResponseHandler, quotation);
		}
	},
	startLoaded: function(id) {
		//this.quotation = new Quotation({startMode: "loader"});
		quotation.quotationId = id;
		quotation.startMode = "Loader";
		var reqdata = {
			quotationId : id
		};
		var reqdata = "requestType=QuotationLoaderRequest&requestData=" + JSON.stringify(reqdata);
		var request = new ServerRequest({requrl: $("#quotation_loader_request-url").val(), requestType: "QuotationLoaderRequest"});
		request.sendRequestAndNotify(reqdata, quotation.serverResponseHandler, quotation);
		/*var comm = new Communicator;
		comm.sendRequest(req, $("#quotation_loader_request-url").val(), this.startLoadedCallback, this);*/
	}
});

$(function() {
	var loader = new Loader();
	Backbone.history.start();
	/*var specsView = new SpecsView({el: "#quotation_info_tile_init"});
	specsView.setQuotation(quotation);
	specsView.render();*/
});
