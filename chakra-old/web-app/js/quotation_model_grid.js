// JavaScript Document

var ServerRequest = Backbone.Model.extend({
	initialize: function() {
		console.log("ServerRequest initialized");
	},
	sendRequestAndNotify: function(req, callback, context) {
		this.responseCallback = callback;
		this.responsecallbackContext = context;
		var comm = new Communicator();
		comm.sendRequest(req, this.get('requrl'), this.getResponse, this);
	},
	getResponse: function(stat, data, jqXHR)
	{
		if(stat == "Success")
		{
			this.responseCallback.call(this.responsecallbackContext, this.get('requestType'), jqXHR);
		}
	},
});

var CagePartTypeInfo = Backbone.Model.extend({
	defaults: {
		cagePartType: null,
		cagePartSpec: null
	}
});

var ChainLinkInfo = Backbone.Model.extend({
	defaults: {
		linkMeshId: null,
		length1: 0,
		height: 0,
		noOfPieces: 0,
		wireBrand: null
	}
});

var WeldSideInfo = Backbone.Model.extend({
	defaults: {
		sideMeshId: null,
		length1: 0,
		height: 0,
		noOfPieces: 0,
		wireBrand: null
	}
});

var CagePartTypeInfoList = Backbone.Collection.extend({
	model: CagePartTypeInfo
});

var ChainLinkInfoList = Backbone.Collection.extend({
	model: ChainLinkInfo
});

var WeldSideInfoList = Backbone.Collection.extend({
	model: WeldSideInfo
});

var QuotationModel = Backbone.Model.extend({
	defaults: {
		"id": null,
		"cageDesign": null,
		"noOfBirds": 0,
		"costPerBird": 0,
		"cost": 0,
		"tax": 0,
		"totalCost": 0,
		"cagePartTypes": new CagePartTypeInfoList()
	},
	initialize: function() {
		console.log("QuotationModel Created!");
	}
});

var QuotationModelList = Backbone.Collection.extend({
	model: QuotationModel
});


var QuotationModelGridView = Backbone.View.extend({
	initialize: function() {
		this.EventHandlers = new Array();
		this.currentSelectedModelRow = null;
		this.showConfirmButton = true;
	},
	events: {
		"click #model_add-btn":"event_addModelAddBtnClicked",
		"mouseenter .model-grid-row": "event_mouseEnterModelRow",
		"mouseleave .model-grid-row": "event_mouseLeaveModelRow",
		"click .model-grid-row": "event_clickModelRow",
		"click .model-submit-button":"event_confirmBtnClicked",
		"click .model-print-button":"event_printBtnClicked"
	},
	event_addModelAddBtnClicked: function(e) {
		this.disableModelAddBtn();
		this.notifyEventToHandlers("event_addModelAddBtnClicked", null);
	},
	event_mouseEnterModelRow: function(e) {
		var element = e.currentTarget;
		if($(element) != this.currentSelectedModelRow)
			$(element).addClass("model-grid-row_expanded");
	},
	event_mouseLeaveModelRow: function(e) {
		var element = e.currentTarget;
		if($(element) != this.currentSelectedModelRow)
			$(element).removeClass("model-grid-row_expanded");
	},
	event_clickModelRow: function(e) {
		var element = e.currentTarget;
		if(this.currentSelectedModelRow) {
			$(this.currentSelectedModelRow).removeClass("model-grid-row_selected");
			this.currentSelectedModelRow = null;
		}
		$(element).removeClass("model-grid-row_expanded");
		$(element).addClass("model-grid-row_selected");
		this.currentSelectedModelRow = $(element);
		var id = $(element).children(".model-grid-row-data").eq(0).attr("name");
		this.notifyEventToHandlers("event_clickModelRow", $(element).children(".model-grid-row-data").attr("name"));
	},
	event_confirmBtnClicked: function(e) {
		var form = $(e.currentTarget).parents("form");
		this.notifyEventToHandlers("event_confirmBtnClicked", form);
		e.preventDefault();
	},
	event_printBtnClicked: function(e) {
		var form = $(e.currentTarget).parents("form");
		this.notifyEventToHandlers("event_printBtnClicked", form);
		e.preventDefault();
	},
	render: function(templateId, params) {
		var template = _.template($(templateId).html(), params);
		this.$el.html(template);
	},
	getQuotationModelRow: function(modelId) {
		return this.$(".models-box").find(".model-grid-row .model-grid-row-data[name="+modelId+"]").eq(0).parent();
	},
	addQuotationModelRow: function(model, cagePartTypes) {
		var modelJson = model.toJSON();
		modelJson.showConfirmButton = this.showConfirmButton;
		var row = _.template($("#model_row_template").html(), modelJson);
		row = $(row);
		var info = $(row).find(".cageparttype-info");
		for(var i in cagePartTypes)
		{
			var inf = _.template($("#model_row_cageparttype_info").html(), cagePartTypes[i]);
			//console.log(inf);
			$(info).append($(inf)); 
		}
		this.$(".models-box").append(row);
	},
	updateQuotationModelRow: function(model) {
		var modelJson = model.toJSON();
		modelJson.showConfirmButton = this.showConfirmButton;
		var row = _.template($("#model_row_template").html(), modelJson);
		row = $(row);
		var info = $(row).find(".cageparttype-info");
		for(var i in model.get('cagePartTypes'))
		{
			var inf = _.template($("#model_row_cageparttype_info").html(),model.get('cagePartTypes')[i]);
			//console.log(inf);
			$(info).append($(inf)); 
		}
		var oldRow = this.getQuotationModelRow(model.get('id'));
		console.log(oldRow);
		$(oldRow).html(row.html());
	},
	addEventHandler: function(handler, context) {
		this.EventHandlers.push({"handler": handler, "context": context});
	},
	notifyEventToHandlers: function(event_type, event_data) {
		for(var h in this.EventHandlers) {
			var handler = this.EventHandlers[h].handler;
			var context = this.EventHandlers[h].context;
			handler.call(context, event_type, event_data);
		}
	},
	
	// interface functions
	enableModelAddBtn: function() {
		this.$("#model_add-btn").removeAttr("disabled");
	},
	disableModelAddBtn: function() {
		this.$("#model_add-btn").attr("disabled","true");
	},
	selectQuotationModelRow: function(modelId) {
		var obj = this.$(".models-box .model-grid-row .model-grid-row-data[name="+modelId+"]").eq(0);
		$(obj).trigger("click");
	}
});

var QuotationModelGrid = Backbone.Model.extend({
	initialize: function() {
		this.view = new QuotationModelGridView({el: this.get('container')});
		this.view.render("#models_grid_template",{});
		this.view.addEventHandler(this.viewEventHandler, this);
		this.modelsList = new QuotationModelList();
		this.eventHandlers = new Array();
	},
	viewEventHandler: function(event_type, event_data) {
		switch(event_type) {
			case "event_addModelAddBtnClicked":
			{ 
				
			}
			break;
			case "event_clickModelRow":
			{
				//data = this.modelsList.get(event_data);
			}
			break;
		}
		this.notifyEvent(event_type, event_data);
	},
	
	registerEventHandler: function(eventType, handler, context) {
		this.eventHandlers[eventType] = { handler: handler, context: context };
	},
	notifyEvent: function(eventType, eventData) {
		if( this.eventHandlers[eventType] ) {
			var tmp = this.eventHandlers[eventType];
			tmp.handler.call(tmp.context, eventData);
		}
	},
	
	// interface function
	addQuotationModel: function(model, cagePartTypes) {
		this.modelsList.add(model);
		//console.log(this.modelsList.toJSON());
		this.view.addQuotationModelRow(model, cagePartTypes);
		return true;
	},
	getQuotationModel: function(modelId) {
		return this.modelsList.get(modelId);
	},
	updateQuotationModel: function(model) {
		this.modelsList.add(model.toJSON());
		//console.log(this.modelsList);
		this.view.updateQuotationModelRow(model);
		return true;
	},
	enableModelAddBtn: function() {
		this.view.enableModelAddBtn();
	},
	disableModelAddBtn: function() {
		this.view.disableModelAddBtn();
	},
	selectQuotationModel: function(modelId) {
		this.view.selectQuotationModelRow(modelId);
	},
	hideConfirmButton: function() {
		this.view.showConfirmButton = false;
	}
});


var ModelAddRequest = Backbone.Model.extend({
	defaults: {
	},
	initialize: function() {
		this.cagePartTypes = new CagePartTypeInfoList;
		this.chainLinkItems = new ChainLinkInfoList;
		this.weldSideItems = new WeldSideInfoList;
		/*console.log(JSON.stringify(this.cagePartTypes.toJSON()));*/
		this.hasMeshPart = false;
		this.hasCagePart = false;
		this.hasChainLink = false;
		this.hasWeldSide = false;
		console.log("Model: ModelRequest Initialized");
	},
	addCagePartTypeInfo: function(type, spec) {
		var tmp =  new CagePartTypeInfo({ 
			cagePartType: type,
			cagePartSpec: spec
		});
		this.hasCagePart = true;
		this.cagePartTypes.add(tmp);
	},
	addChainLinkInfo: function(id, length, height, noOfPieces, wireBrand) {
		var tmp = new ChainLinkInfo({
			linkMeshId: id,
			length1: length,
			height: height,
			noOfPieces: noOfPieces,
			wireBrand: wireBrand
		});
		this.hasChainLink = true;
		console.log(tmp.toJSON());
		this.chainLinkItems.add(tmp);
	},
	addWeldSideInfo: function(id, length, height, noOfPieces, wireBrand) {
		var tmp = new WeldSideInfo({
			sideMeshId: id,
			length1: length,
			height: height,
			noOfPieces: noOfPieces,
			wireBrand: wireBrand
		});
		this.hasWeldSide = true;
		console.log(tmp.toJSON());
		this.weldSideItems.add(tmp);
	},
	addMeshPart: function(wireBrand) {
		this.hasMeshPart = true;
		this.meshPart = wireBrand;
	},
	getModelAddRequestData: function(qid, taxId) {
		//var context = this.get('context');
		var obj={};
		obj.quotationId = qid;
		console.log(obj.quotationId);
		obj.hasCagePart = this.hasCagePart;
		obj.hasMeshPart = this.hasMeshPart;
		obj.hasChainLink = this.hasChainLink;
		obj.hasWeldSide = this.hasWeldSide;
		obj.cageDesign = this.get('cageDesign');
		obj.cagePartTypes = this.cagePartTypes.toJSON();
		obj.chainLinkItems = this.chainLinkItems.toJSON();
		obj.weldSideItems = this.weldSideItems.toJSON();
		obj.meshPart = this.meshPart;
		obj.taxation = taxId;
		
		//var comm = new Communicator;
		//comm.sendRequest(req, this.get('url'), this.submitModelAddRequestCallback, this);
		return obj;
	}/*,
	submitModelAddRequestCallback: function (status, data, jqXHR)
	{
		if(status=="Success")
		{
			//var context = this.get('context');
			//var resp = $.parseJSON(jqXHR.reponseText);
			//var newModel = new Model(resp.responseData);
			//context.addModel(newModel);
			this.callback.call(this.callbackContext, jqXHR.responseText);
		}
	},
	registerCallback: function(callback, context) {
		this.callback = callback;
		this.callbackContext = context;
	}*/
});

var ModelAddPopupView = Backbone.View.extend({
	initialize: function() {
		this.selectedCagePartTypes = new Array();
		this.EventHandlers = new Array();
	},
	events: {
		"click #model_field_add-btn":"event_modelFieldAddBtnClicked",
		"change select[name=cagePartType]":"event_cagePartTypeChanged",
		"change #model_add_dialogue_cage_design_type":"event_cageDesignTypeSelcted",
		"change #model_add_dialogue_cage_design":"event_cageDesignSelected",
		"click #model_fields_submit-btn":"event_submitBtnClicked",
		"click #model_fields_cancel-btn":"event_cancelBtnClicked",
		"change select[name=cagePartSpec]":"event_cagePartSpecChanged"
	},
	
	// event handler functions
	event_modelFieldAddBtnClicked: function(e) {
		var tmp = $("#model_add_dialogue_field_box_content").html();
		tmp = $(tmp);
		var context = this;
		console.log("this.selectedCagePartTypes:");
		console.log(this.selectedCagePartTypes);
		$(tmp).children("select[name=cagePartType]").children("option").each(function(index, element) {
			if($(element).hasClass("option-cage-part") || $(element).hasClass("option-mesh-part"))
			{
				console.log("Checking: "+$(element).attr('value'));
            	if(context.selectedCagePartTypes[$(element).attr('value')])
					$(element).remove();
			}
        });
		this.$("#model_add_dialogue_field_box").append(tmp);
	},
	event_cagePartTypeChanged: function(e) {
		var val = $(e.currentTarget).val();
		this.currentSpecElem = $(e.currentTarget);
		
		// filtering code
		var element = $(e.currentTarget).children("option[value="+$(e.currentTarget).val()+"]");
		console.log($(element));
		if($(element).hasClass("option-cage-part")) {
			
		} else if($(element).hasClass("option-mesh-part")) {
			$(this.currentSpecElem).parent().children("select[name=cagePartSpec]").html($("#wirebrand_select_options").html());
			return;
		} else if($(element).hasClass("option-chain-link")) {
			var html = $("#model_add_dialogue_field_box_content_additional_fields").html();
			$(e.currentTarget).parent().append($(html));
			$(this.currentSpecElem).parent().children("select[name=cagePartSpec]").html($("#chain_link_items_template").html());
			return;
		} else if($(element).hasClass("option-weld-side")) {
			var html = $("#model_add_dialogue_field_box_content_additional_fields").html();
			$(e.currentTarget).parent().append($(html));
			$(this.currentSpecElem).parent().children("select[name=cagePartSpec]").html($("#weld_side_items_template").html());
			return;
		}
		// end filtering code
		var reqdata =  {
			"id" : val
		};
		var req = new ServerRequest({requrl: $("#cagepartspec_get-url").val(), requestType: "CagePartSpecRequest"});
		req.sendRequestAndNotify('requestType=CagePartSpecRequest&requestData='+JSON.stringify(reqdata), this.serverResponseHandler, this);
	},
	event_cageDesignTypeSelcted: function(e) {
		var val = $(e.currentTarget).val();
		var reqdata =  {
			"id" : val
		};
		this.currentSpecElem = $(e.currentTarget);
		var req = new ServerRequest({requrl: $("#cagedesign_get-url").val(), requestType: "CageDesignRequest"});
		req.sendRequestAndNotify('requestType=CageDesignRequest&requestData='+JSON.stringify(reqdata), this.serverResponseHandler, this);
	},
	event_cageDesignSelected: function(e) {
		this.$("#model_fields_submit-btn").removeAttr("disabled");
		$("#model_field_add-btn").trigger("click");
	},
	event_submitBtnClicked: function(e) {
		var modelAddRequest = new ModelAddRequest();
		modelAddRequest.set({cageDesign: this.$("#model_add_dialogue_cage_design").val(), 'url':$("#modeladd-url").val()});
		var tmp = this;
		this.$("#model_add_dialogue_field_box").children().each(function(index, element) {
			console.log(":"+$(element).children("select[name=cagePartSpec]").eq(0).val()+":");
			if($(element).children("select[name=cagePartSpec]").eq(0).val() != "" && $(element).children("select[name=cagePartSpec]").eq(0).val())
			{
				var option = $(element).children("select[name=cagePartType]").children("option[value="+$(element).children("select[name=cagePartType]").val()+"]");
				console.log("[doSubmit]:");
				console.log(option);
				if($(option).hasClass("option-cage-part"))
				{
					modelAddRequest.addCagePartTypeInfo($(element).children("select[name=cagePartType]").val(),
							$(element).children("select[name=cagePartSpec]").val());
				}
				else if($(option).hasClass("option-mesh-part"))
				{
					modelAddRequest.addMeshPart($(element).children("select[name=cagePartSpec]").val());
				}
				else if($(option).hasClass("option-chain-link"))
				{
					var selement = $(element).children(".model-add-dialogue-add-field-additional-fields").eq(0);
					modelAddRequest.addChainLinkInfo(
						$(element).find("select[name=cagePartSpec]").val(),
						$(selement).find("input[name=length]").attr('value'),
						$(selement).find("input[name=height]").val(),
						$(selement).find("input[name=noOfPieces]").val(),
						$(selement).find("select[name=wireBrand]").val()
					);
				}
				else if($(option).hasClass("option-weld-side"))
				{
					var selement = $(element).children(".model-add-dialogue-add-field-additional-fields").eq(0);
					modelAddRequest.addWeldSideInfo(
						$(element).find("select[name=cagePartSpec]").val(),
						$(selement).find("input[name=length]").val(),
						$(selement).find("input[name=height]").val(),
						$(selement).find("input[name=noOfPieces]").val(),
						$(selement).find("select[name=wireBrand]").val()
					);
				}
			}
		});
		//console.log(modelAddRequest);
		//this.model.registerCallback(this.doSubmitCallback,this);
		//var req = modelAddRequest.getModelAddRequest();
		//var reqObj = new ServerRequest({requrl: $("#modeladd-url").val(), "requestType" :"QuotationModelAddRequest"});
		//reqObj.sendRequestAndNotify(req, this.serverResponseHandler, this);
		this.notifyEventToHandlers("event_submitBtnClicked", modelAddRequest);
		this.$el.remove();
	},
	event_cancelBtnClicked: function(e) {
		this.$el.remove();
		this.notifyEventToHandlers("event_cancelBtnClicked");
	},
	event_cagePartSpecChanged: function(e) {
		var element = e.currentTarget;
		var cagePartTypeVal = $(element).parent().children("select[name=cagePartType]").eq(0).val();
		this.selectedCagePartTypes[cagePartTypeVal] = true;
		$("#model_field_add-btn").trigger("click");
	},
	serverResponseHandler: function(reqType, jqXHR) {
		console.log('in serverResponseHandler: ' + reqType);
		switch(reqType)
		{
			case "CagePartSpecRequest":
			{
				var elem = $("<select></select>").html(jqXHR.responseText);
				var specs = new Array();
				$(elem).children("option").each(function(index, element) {
                    var id = $(element).attr("value");
					var name = $(element).text();
					if(name != "Select") {
						specs[id] = new Object({specId: id, specName: name});
					}
                });
				$(this.currentSpecElem).parent().children("select[name=cagePartSpec]").html(jqXHR.responseText);
				this.notifyEventToHandlers("event_cagePartSpecRequest", specs);
			}
			break;
			case "CageDesignRequest":
			{
				$(this.currentSpecElem).parent().children("#model_add_dialogue_cage_design").html(jqXHR.responseText);
			}
		}
	},
	// locally used functions
	addEventHandler: function(handler, context) {
		this.EventHandlers.push({"handler": handler, "context": context});
	},
	notifyEventToHandlers: function(event_type, event_data) {
		for(var h in this.EventHandlers) {
			var handler = this.EventHandlers[h].handler;
			var context = this.EventHandlers[h].context;
			handler.call(context, event_type, event_data);
		}
	},
	
	// interface functions
	render: function(templateId, params) {
		var template = _.template($(templateId).html(), params);
		this.$el.html(template);
		this.$("#model_fields_submit-btn").attr("disabled","true");
	},
	setPosition: function() {
		var width = $(this.$el).outerWidth();
		var height =  $(this.$el).outerHeight();
		var docWidth = window.innerWidth;
		var docHeight = window.innerHeight;
		var offset = new Object();
		offset.left = (docWidth - width)/2;
		offset.top = (docHeight - height)/3;
		$(this.$el).offset(offset);
	}
});

var ModelAddPopup = Backbone.Model.extend({
	initialize: function(e) {
		this.eventHandlers = new Array();
		this.view = new ModelAddPopupView({el: this.get('container')});
		this.view.addEventHandler(this.viewEventHandler, this);
		this.view.render("#model_add_dialogue_content");
		this.view.setPosition();
	},
	
	// locally used functions
	viewEventHandler: function(event_type, event_data) {
		console.log("in viewEventHandler: "+event_type);
		var data = event_data;
		switch(event_type) {
			case "event_addModelAddBtnClicked":
			{ 
				//this.notifyEvent(event_type, event_data);
			}
			break;
			case "event_clickModelRow":
			{
				data = this.modelsList.get(event_data);
				//this.notifyEvent(event_type, data);
			}
			break;
			case "event_submitBtnClicked":
			{
				//this.notifyEvent(event_type, event_data);
			}
			break;
			case "event_cancelBtnClicked":
			{
				//this.notifyEvent(event_type, event_data);
			}
			break;
		}
		this.notifyEvent(event_type, data);
	},
	
	// interface funtions
	registerEventHandler: function(eventType, handler, context) {
		this.eventHandlers[eventType] = { handler: handler, context: context };
	},
	notifyEvent: function(eventType, eventData) {
		if( this.eventHandlers[eventType] ) {
			var tmp = this.eventHandlers[eventType];
			tmp.handler.call(tmp.context, eventData);
		}
	}
});