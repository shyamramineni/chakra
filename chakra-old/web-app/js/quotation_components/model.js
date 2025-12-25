// JavaScript Document
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
	submitModelAddRequest: function() {
		//var context = this.get('context');
		var obj={};
		obj.quotationId = this.quotation.get('id');
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
		obj.taxation = this.quotation.taxId;
		var req="requestType=QuotationModelAddRequest&requestData="+JSON.stringify(obj);
		var comm = new Communicator;
		comm.sendRequest(req, this.get('url'), this.submitModelAddRequestCallback, this);
	},
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
	}
});

var ModelInfoSummaryItem = Backbone.Model.extend({
	id: null,
	sheetId: null,
	sheetSpec: null,
	wirebrand: null,
	partCount: 0,
	cost: 0
});

var ModelInfoSummaryItemList = Backbone.Collection.extend({
	model: ModelInfoSummaryItem
});

var ModelInfo = Backbone.Model.extend({
	basicInfo: {
	},
	summary: null,
	initialize: function() {
		summary = new ModelInfoSummaryItemList;
	}
});

var Model = Backbone.Model.extend({
	defaults: {
		"id": null,
		"cageDesign": null,
		"noOfBirds": 0,
		cost: 0,
		"tax": 0,
		totalCost: 0,
		cagePartTypes: 0
	},
	initialize: function() {
	}
});

var ModelList = Backbone.Collection.extend({
	model: Model
});

var ModelGrid = Backbone.Model.extend({
	modelList: null,
	initialize: function(){
		this.modelList = new ModelList();
		this.modelInfoView = new TabbedPanel({el : "#models_info_tile"});
		this.modelInfoView.quotation = this.get('context');
		this.isEditable = true;
	},
	addModel: function(response)
	{
		this.modelList.add(response.model);
		this.modelInfoView.addModel(response);
	},
	iseditable: function(flag)
	{
		this.isEditable = flag;
		this.modelInfoView.iseditable(flag);
	}
});

var ModelAddPopupView = Backbone.View.extend({
	initialize: function() {
		this.render();
		this.model = new ModelAddRequest();
		this.render();
		this.addField();
		this.setPosition();
		this.$("#model_fields_submit-btn").attr("disabled","true");
		console.log("View: ModelAddPopupView Initialized!");
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
	},
	events: {
		"click #model_field_add-btn":"addField",
		"change select[name=cagePartType]":"doGetSpec",
		"change #model_add_dialogue_cage_design_type":"doGetDesign",
		"change #model_add_dialogue_cage_design":"enableSubmit",
		"click #model_fields_submit-btn":"doSubmit",
		"click #model_fields_cancel-btn":"closePopup",
		"change select[name=cagePartSpec]":"updateSelectedItemsList"
	},
	enableSubmit: function(e) {
		this.$("#model_fields_submit-btn").removeAttr("disabled");
	},
	doSubmit: function(e) {
		this.model.quotation = this.quotation;
		this.model.set({cageDesign: this.$("#model_add_dialogue_cage_design").val(), 'url':$("#modeladd-url").val()});
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
					tmp.model.addCagePartTypeInfo($(element).children("select[name=cagePartType]").val(),
							$(element).children("select[name=cagePartSpec]").val());
				}
				else if($(option).hasClass("option-mesh-part"))
				{
					tmp.model.addMeshPart($(element).children("select[name=cagePartSpec]").val());
				}
				else if($(option).hasClass("option-chain-link"))
				{
					var selement = $(element).children(".model-add-dialogue-add-field-additional-fields").eq(0);
					tmp.model.addChainLinkInfo(
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
					tmp.model.addWeldSideInfo(
						$(element).find("select[name=cagePartSpec]").val(),
						$(selement).find("input[name=length]").val(),
						$(selement).find("input[name=height]").val(),
						$(selement).find("input[name=noOfPieces]").val(),
						$(selement).find("select[name=wireBrand]").val()
					);
				}
			}
		});
		this.model.registerCallback(this.doSubmitCallback,this);
		this.model.submitModelAddRequest();
	},
	closePopup: function() {
		$("#model_add-btn").removeAttr("disabled");
		this.$el.remove();
	},
	doSubmitCallback: function(model) {
		var json = $.parseJSON(model);
		console.log(this.quotation);
		this.quotation.addModel(json.responseData);
		this.closePopup();
	},
	doGetDesign: function(e) {
		var val = $(e.currentTarget).val();
		var req =  {
			"id" : val
		};
		var comm = new Communicator;
		this.currentSpecElem = $(e.currentTarget);
		comm.sendRequest('requestType=CageDesignRequest&requestData='+JSON.stringify(req), $("#cagedesign_get-url").val(), this.doGetDesignCallback, this);
	},
	doGetDesignCallback: function(stat, data, jqXHR) {
		if(stat == "Success")
		{
			//var json = $.parseJSON(jqXHR.responseText);
			$(this.currentSpecElem).parent().children("#model_add_dialogue_cage_design").html(data);
		}
	},
	doGetSpec: function(e) {
		var val = $(e.currentTarget).val();
		this.currentSpecElem = $(e.currentTarget);
		
		// filtering code
		var element = $(e.currentTarget).children("option[value="+$(e.currentTarget).val()+"]");
		console.log($(element));
		if($(element).hasClass("option-cage-part")) {
			
		} else if($(element).hasClass("option-mesh-part")) {
			this.doGetSpecCallback("Success",$("#wirebrand_select_options").html(),null);
			return;
		} else if($(element).hasClass("option-chain-link")) {
			var html = $("#model_add_dialogue_field_box_content_additional_fields").html();
			$(e.currentTarget).parent().append($(html));
			this.doGetSpecCallback("Success", $("#chain_link_items_template").html(),null);
			return;
		} else if($(element).hasClass("option-weld-side")) {
			var html = $("#model_add_dialogue_field_box_content_additional_fields").html();
			$(e.currentTarget).parent().append($(html));
			this.doGetSpecCallback("Success", $("#weld_side_items_template").html(),null);
			return;
		}
		// end filtering code
		var req =  {
			"id" : val
		};
		var comm = new Communicator;
		comm.sendRequest('requestType=CagePartSpecRequest&requestData='+JSON.stringify(req), $("#cagepartspec_get-url").val(), this.doGetSpecCallback, this);
	},
	doGetSpecCallback: function(stat, data, jqXHR) {
		if(stat == "Success")
		{
			//var json = $.parseJSON(jqXHR.responseText);
			$(this.currentSpecElem).parent().children("select[name=cagePartSpec]").html(data);
		}
	},
	updateSelectedItemsList: function(e) {
		var element = $(e.currentTarget).parent().children("select[name=cagePartType]").eq(0);
		this.selectedCagePartTypes[$(element).val()] = true;
		this.addField();
	},
	addField: function() {
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
	render: function() {
		// this variable is used to keep track of what is selected on the left dropdown
		// inorder to filter the already added items
		this.selectedCagePartTypes = new Array();
		var temp = _.template($("#model_add_dialogue_content").html(), {});
		this.$el.html(temp);
	}
});

var ModelGridView  = Backbone.View.extend({
	initialize: function() {
		this.isEditable = true;
		this.render();
		console.log("VIEW: ModelGridView Initialized!");
	},
	iseditable: function(flag) {
		this.isEditable = flag;
	},
	registerModelAddCallback: function() {
		this.quotation.registerModelAddCallback(this.doModelAddCallback, this);
	},
	events: {
		"click #model_add-btn":"doModelAdd",
		"mouseenter .model-grid-row": "expandModelRow",
		"mouseleave .model-grid-row": "collapseModelRow",
		"click .model-grid-row": "selectModelRow",
		"click .model-submit-button":"doModelConfirm"
	},
	doModelConfirm: function(e) {
		var form = $(e.currentTarget).parents("form");
		$(form).children("input.quot-id").eq(0).attr("value", this.quotation.get('id'));
		$(form).children("input.quot-model-id").eq(0).attr("value",$(form).parents(".model-grid-row-data").attr("name"));
		e.preventDefault();
		$(form).submit();
	},
	expandModelRow: function(e) {
		var element = e.currentTarget;
		if($(element) != this.currentSelectedModelRow)
			$(element).addClass("model-grid-row_expanded");
	},
	collapseModelRow: function(e) {
		var element = e.currentTarget;
		if($(element) != this.currentSelectedModelRow)
			$(element).removeClass("model-grid-row_expanded");
	},
	selectModelRow: function(e) {
		var element = e.currentTarget;
		if(this.currentSelectedModelRow) {
			$(this.currentSelectedModelRow).removeClass("model-grid-row_selected");
			this.currentSelectedModelRow = null;
		}
		$(element).removeClass("model-grid-row_expanded");
		$(element).addClass("model-grid-row_selected");
		this.currentSelectedModelRow = $(element);
		var id = $(element).children(".model-grid-row-data").eq(0).attr("name");
		this.quotation.modelGrid.modelInfoView.triggerTab(id);
	},
	doModelAdd: function() {
		if(this.isEditable)
		{
			var holder = $('<div id="model_add_popup_container"></div>');
			//holder.append($("#model_add_dialogue_content").html());
			$("body").append(holder);
			this.modelAddPopupView = new ModelAddPopupView({el: "#model_add_popup_container"});
			this.modelAddPopupView.quotation = this.quotation;
			this.quotation.registerModelAddCallback(this.doModelAddCallback, this);
			$("#model_add-btn").attr("disabled","true");
		}
	},
	doModelAddCallback: function() {
		var tmp = this;
		$("#model_add-btn").removeAttr("disabled");
		tmp.$(".models-box").html("");
		this.quotation.modelGrid.modelList.each(function(element, index) {
			console.log(element);
			var json = element.toJSON();
			
			json.status = tmp.quotation.quotInfo.get('status');
			var row = _.template($("#model_row_template").html(), json);
			row = $(row);
			var info = $(row).find(".cageparttype-info");
			for(var i in element.get('cagePartTypes'))
			{
				var inf = _.template($("#model_row_cageparttype_info").html(),element.get('cagePartTypes')[i]);
				//console.log(inf);
				$(info).append($(inf)); 
			}
			tmp.$(".models-box").append(row);
		});
	},
	triggerRow: function(id) {
		var element = this.$(".model-grid-row-data[name="+id+"]");
		if(this.currentSelectedModelRow) {
			$(this.currentSelectedModelRow).removeClass("model-grid-row_selected");
			this.currentSelectedModelRow = null;
		}
		$(element).removeClass("model-grid-row_expanded");
		$(element).addClass("model-grid-row_selected");
		this.currentSelectedModelRow = $(element);
		var id = $(element).children(".model-grid-row-data").eq(0).attr("name");
	},
	render: function() {
		var temp = _.template($("#models_grid_template").html(), {});
		this.$el.html(temp);
	}
});