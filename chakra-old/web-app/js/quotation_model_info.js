// JavaScript Document
var ModelWithInfo = Backbone.Model.extend({
	initalize: function() {
	}
});

var ModelWithInfoList = Backbone.Collection.extend({
	model: ModelWithInfo
});

var QuotationModelInfoView = Backbone.View.extend({
	initialize: function() {
		this.EventHandlers = new Array();
		this.empty = true;
		this.currentSelection = {};
		this.isEditable = true;
		this.countEditContext = new Array();
		this.modelIdToContentMapper = new Array();
		this.notifyHandlersFlag = true;
		this.cagePartSpecSelection = new Array();
	},
	events: {
		"click .tab-tile":"event_tabTileClicked",
		"click .collapse-panel-header":"event_collapsePanelHeaderClicked",
		"mouseenter .table-data":"event_tableDataMouseEnter",
		"mouseleave .table-data":"event_tableDataMouseLeave",
		"dblclick .table-data":"event_tableDataMouseDblClicked",
		"keydown .table-data .table-input-element":"event_tableDataKeyDown",
		"change #cagePartSpecSelect":"event_cagePartSpecSelectionChanged"
	},
	// event handlers
	event_tabTileClicked: function(e) {
		var element = e.currentTarget;
		if(this.currentSelection.id)
		{
			$(this.currentSelection.tab).removeClass("tab-tile-selected");
			$(this.currentSelection.tabContent).removeClass("tab-tile-content-selected");
		}
		var id = this.currentSelection.id = $(element).addClass("tab-tile-selected").attr("name");
		$(element).addClass("tab-tile-selected");
		this.currentSelection.tab = $(element);
		var content = this.currentSelection.tabContent = this.$(".tab-tile-content[name="+id+"]").eq(0);
		console.log($(content));
		content.addClass("tab-tile-content-selected");
		console.log(this);
		this.notifyEventToHandlers("event_tabTileClicked", id);
	},
	event_collapsePanelHeaderClicked: function(e) {
		var element = e.currentTarget;
		var bodyElement = $(element).parent().children(".collapse-panel-body").eq(0);
		if($(bodyElement).attr("name") == "ex")
		{
			$(bodyElement).slideUp("fast");
			$(bodyElement).attr("name","");
		}
		else
		{
			$(bodyElement).slideDown("fast");
			$(bodyElement).attr("name","ex");
		}
	},
	event_tableDataMouseEnter: function(e) {
		var element = e.currentTarget;
		if(!$(element).hasClass("table-data-selected"))
			$(element).addClass("table-data-highlighted");
	},
	event_tableDataMouseLeave: function(e) {
		var element = e.currentTarget;
		if(!$(element).hasClass("table-data-selected"))
			$(element).removeClass("table-data-highlighted");
	},
	event_tableDataMouseDblClicked: function(e) {
		if(this.isEditable)
		{
			var element = e.currentTarget;
			var context = $(element).parents(".collapse-panel").attr('name');
			console.log("Cage Design:" + context);
			if(!this.countEditContext[context])
				this.countEditContext[context]=new Object();
			if(!this.countEditContext[context].selectedElement)
			{
				this.countEditContext[context].selectedElement = $(element);
				$(element).removeClass("table-data-highlighted");
				$(element).addClass("table-data-selected");
				
				var block = $(element).parents("div.collapse-panel").attr("name");
				switch(block)
				{
					case "cageBlock":
					{
						var bkp = this.countEditContext[context].backupCount = $(element).children(".table-data-itemcount").text();
						var text = '<input type="text" class="table-input-element" value="'+bkp+'" />';
						$(element).children(".table-data-itemcount").html(text);
						$(element).find(".table-input-element").focus();
					}
					break;
					case "meshBlock":
					{
						var bkp = this.countEditContext[context].backupCount = $(element).children(".table-data-itemcount").text();
						var text = '<input type="text" class="table-input-element" value="'+bkp+'" />';
						$(element).children(".table-data-itemcount").html(text);
						$(element).find(".table-input-element").focus();
					}
					break;
					case "chainLink":
					{
						var len = this.countEditContext[context].backupLength = $(element).children(".table-cl-length").text();
						var hei = this.countEditContext[context].backupHeight = $(element).children(".table-cl-height").text();
						var nop = this.countEditContext[context].backupCount = $(element).children(".table-cl-noOfPices").text();
						var text = '<input type="text" class="table-input-element" name="length" value="'+len+'" />';
						$(element).children(".table-cl-length").html(text);
						text = '<input type="text" class="table-input-element" name="height" value="'+hei+'" />';
						$(element).children(".table-cl-height").html(text);
						text = '<input type="text" class="table-input-element" name="noOfPices" value="'+nop+'" />';
						$(element).children(".table-cl-noOfPices").html(text);
						$(element).find(".table-cl-length").focus();
					}
					break;
					case "weldSide":
					{
						var len = this.countEditContext[context].backupLength = $(element).children(".table-ws-length").text();
						var hei = this.countEditContext[context].backupHeight = $(element).children(".table-ws-height").text();
						var nop = this.countEditContext[context].backupCount = $(element).children(".table-ws-noOfPices").text();
						var text = '<input type="text" class="table-input-element" name="length" value="'+len+'" />';
						$(element).children(".table-ws-length").html(text);
						text = '<input type="text" class="table-input-element" name="height" value="'+hei+'" />';
						$(element).children(".table-ws-height").html(text);
						text = '<input type="text" class="table-input-element" name="noOfPices" value="'+nop+'" />';
						$(element).children(".table-ws-noOfPices").html(text);
						$(element).find(".table-ws-length").focus();
					}
					break;
				}
			}
		}
	},
	event_tableDataKeyDown: function(e) {
		var element = e.currentTarget;
		console.log("keyCode: "+e.keyCode);
		var context = $(element).parents(".collapse-panel").attr("name");
		console.log("Context: "+context);
		var row = $(element).parents(".table-data").eq(0);
		if(e.keyCode == 13) {
			this.changedBlock = $(element).parents(".collapse-panel").eq(0);
			$(row).removeClass("table-data-selected");
			this.countEditContext[context].selectedElement = null;
			// code for sending ajax request
			var reqobj = {};
			//var block = $(element).parents("div.collapse-panel").attr("name");
			reqobj.modelId = $(element).parents(".tab-tile-content").attr("name");
			//reqobj.quotationId = this.quotation.get('id');
			var requestType = "";
			var requestUrl = "";
			switch(context)
			{
				case "meshBlock":
				{
					var val = this.countEditContext[context].backupCount = $(element).val();
					reqobj.sheetSpec = $(element).parents(".table-data").eq(0).children("td.table-sheet-id").attr("name");
					reqobj.noOfMeshParts = val;
					$(element).parent().html(val);
					
					requestType = "MeshPartUpdateRequest";
					requestUrl = $("#mesh_part_update_request-url").val();
				}
				break;
				case "cageBlock":
				{
					var val = this.countEditContext[context].backupCount = $(element).val();
					reqobj.cagePart = $(element).parents(".table-data").children("td.table-sheet-id").attr("name");
					reqobj.noOfCageParts = val;
					$(element).parent().html(val);
					
					requestType = "CagePartUpdateRequest";
					requestUrl = $("#cage_part_update_request-url").val();
				}
				break;
				case "chainLink":
				{
					var hei = reqobj.height = this.countEditContext[context].backupHeight 
						= $(row).children("td.table-cl-height").children("input").val();
					var len = reqobj.length = this.countEditContext[context].backupLength 
						= $(row).children("td.table-cl-length").children("input").val();
					var nop = reqobj.noOfPieces = this.countEditContext[context].backupCount 
						= $(row).children("td.table-cl-noOfPices").children("input").val();
					reqobj.linkMeshId = $(element).parents(".table-data").children("td.table-cl-id").attr("name");
					reqobj.chainLinkId = $(element).parents(".table-data").attr("name");
					
					console.log(hei+":"+len+":"+nop);
					
					$(row).children("td.table-cl-height").eq(0).text(hei);
					$(row).children("td.table-cl-length").eq(0).text(len);
					$(row).children("td.table-cl-noOfPices").eq(0).text(nop);
					
					requestType = "ChainLinkUpdateRequest";
					requestUrl = $("#chain_link_update_request-url").val();
				}
				break;
				case "weldSide":
				{
					var hei = reqobj.height = this.countEditContext[context].backupHeight 
						= $(row).children("td.table-ws-height").children("input").val();
					var len = reqobj.length = this.countEditContext[context].backupLength 
						= $(row).children("td.table-ws-length").children("input").val();
					var nop = reqobj.noOfPieces = this.countEditContext[context].backupCount 
						= $(row).children("td.table-ws-noOfPices").children("input").val();
					reqobj.sideMeshId = $(element).parents(".table-data").children("td.table-ws-id").attr("name");
					reqobj.weldSideId = $(element).parents(".table-data").attr("name");
					
					console.log(hei+":"+len+":"+nop);
					
					$(row).children("td.table-ws-height").html(hei);
					$(row).children("td.table-ws-length").html(len);
					$(row).children("td.table-ws-noOfPices").html(nop);
					
					requestType = "WeldSideUpdateRequest";
					requestUrl = $("#weld_side_update_request-url").val();
				}
				break;
			}
			
			var comm = new Communicator();
			var req = "requestType="+requestType+"&requestData="+JSON.stringify(reqobj);
			var obj = {
				requestType: requestType,
				requestUrl: requestUrl,
				reqData: reqobj
			};
			//comm.sendRequest(req, requestUrl, this.costUpdateResponse, this);
			e.preventDefault();
			this.notifyEventToHandlers("event_tableDataKeyDown", obj);
		} else if(e.keyCode == 27) {
			$(element).parent().removeClass("table-data-selected");
			switch(context)
			{
				case "cageBlock":
				{
					var val = this.countEditContext[context].backupCount;
					$(element).parent().html(val);
				}
				break;
				case "meshBlock":
				{
					var val = this.countEditContext[context].backupCount;
					$(element).parent().html(val);
				}
				break;
				case "chainLink":
				{
					var hei = this.countEditContext[context].backupHeight;
					var len = this.countEditContext[context].backupLength;
					var nop = this.countEditContext[context].backupCount;
					
					$(row).children("td.table-cl-height").eq(0).text(hei);
					$(row).children("td.table-cl-length").eq(0).text(len);
					$(row).children("td.table-cl-noOfPices").eq(0).text(nop);
				}
				break;
				case "weldSide":
				{
					var hei = this.countEditContext[context].backupHeight;
					var len = this.countEditContext[context].backupLength;
					var nop = this.countEditContext[context].backupCount;
					
					$(row).children("td.table-ws-height").html(hei);
					$(row).children("td.table-ws-length").html(len);
					$(row).children("td.table-ws-noOfPices").html(nop);
				}
				break;
			}
			this.countEditContext[context].selectedElement = null;
			/*var val = this.countEditContext[cageDesign].backupCount;
			$(element).parent().html(val);*/
			e.preventDefault();
		}
	},
	event_cagePartSpecSelectionChanged: function(e) {
		var elem = e.currentTarget;
		var val = $(elem).val();
		var id = $(elem).parents(".tab-tile-content").attr("name");
		this.cagePartSpecSelection[id] = val;
		var model = this.modelIdToContentMapper[id].model;
		this.renderCageBlock(model, val);
	},
	// locally used functions
	notifyEventToHandlers: function(event_type, event_data) {
		if(this.notifyHandlersFlag)
			for(var h in this.EventHandlers) {
				var handler = this.EventHandlers[h].handler;
				var context = this.EventHandlers[h].context;
				handler.call(context, event_type, event_data);
			}
	},
	
	// interface functions
	addEventHandler: function(handler, context) {
		this.EventHandlers.push({"handler": handler, "context": context});
	},
	render: function(templateId, params) {
		var template = _.template($(templateId).html(), params);
		this.$el.html(template);
	},
	addModel: function(model, cagePartSpecs) {
		if(this.empty) {
			this.render("#tabbed_panel_content",{});
		}
		this.cagePartSpecs = cagePartSpecs;
		var modelJson = model.toJSON();
		var modelInfo = modelJson.modelInfo;
		modelJson.cagePartSpecs = cagePartSpecs;
		// rendering tiles
		var tab = _.template($("#tab_tile_template").html(), modelJson);
		tab = $(tab);
		this.$(".tabs-holder").eq(0).append(tab);
		
		// rendering data block structure
		var content = _.template($("#tab_body_template").html(), modelJson);
		content = $(content);
		this.$(".tabs-content-holder").eq(0).append(content);
		
		this.modelIdToContentMapper[model.get('id')] = {tab: tab, content: content, model: model};
		
		// rendering individual blocks
		if(modelInfo.meshPartsDetails)
			this.renderMeshBlock(model);
		if(modelInfo.cagePartsDetails)
			this.renderCageBlock(model);
		if(modelInfo.chainLinkDetails)
			this.renderChainLink(model);
		if(modelInfo.weldSideMeshDetails)
			this.renderWeldSide(model);
		
		this.empty = false;
	},
	updateModel: function(model) {
		var modelJson = model.toJSON();
		var modelInfo = modelJson.modelInfo;
		var id = model.get('id');
		modelJson.cagePartSpecs = this.cagePartSpecs;
		
		// rendering individual blocks
		if(modelInfo.meshPartsDetails)
			this.renderMeshBlock(model);
		if(modelInfo.cagePartsDetails)
			this.renderCageBlock(model, this.cagePartSpecSelection[id]);
		if(modelInfo.chainLinkDetails)
			this.renderChainLink(model);
		if(modelInfo.weldSideMeshDetails)
			this.renderWeldSide(model);
	},
	renderMeshBlock: function(model) {
		var modelInfo = model.get("modelInfo");
		var obj = {meshPartsDetails: modelInfo.meshPartsDetails};
		var contentObj = $(this.modelIdToContentMapper[model.get('id')].content);
		var cpanel = $(contentObj).children(".collapse-panel[name=meshBlock]");
		var dat = _.template($("#mesh_part_contents_template").html(), modelInfo);
		if($(cpanel).children(".collapse-panel-header").length > 0) {
			var new_cpanel = $("<div></div>").html(dat);
			$(cpanel).children(".collapse-panel-header").html($(new_cpanel).children(".collapse-panel-header").html());
			$(cpanel).children(".collapse-panel-body").html($(new_cpanel).children(".collapse-panel-body").html());
		} else {
			$(cpanel).html(dat);
		}
		//var new_cpanel = $(content).children(".collapse-panel[name=meshBlock]");
		
		
	},
	renderCageBlock: function(model, spec) {
		var modelInfo = model.get("modelInfo");
		var obj = {cagePartsDetails: {}};
		var contentObj = $(this.modelIdToContentMapper[model.get('id')].content);
		var cpanel = $(contentObj).children(".collapse-panel[name=cageBlock]");
		var template;
		if(! spec) {
			obj.cagePartsDetails.model = modelInfo.cagePartsDetails.model;
			obj.cagePartsDetails.parts = {rows: new Array()};
			var rows = modelInfo.cagePartsDetails.parts.rows;
			for( i in rows ) {
				for( j in rows[i].cageParts )
					obj.cagePartsDetails.parts.rows.push(rows[i].cageParts[j]);
			}
			obj.cagePartsDetails.parts.cagePartCost = modelInfo.cagePartsDetails.parts.cagePartCost;
			obj.cagePartsDetails.parts.cagePartTax = modelInfo.cagePartsDetails.parts.cagePartTax;
			template = "#cage_part_contents_template";
		} else {
			var specData;
			var rows = modelInfo.cagePartsDetails.parts.rows;
			for( i in rows ) {
				if(rows[i].cagePartSpec.cagePartSpecificationId == spec) {
					specData = rows[i];
					break;
				}
			}
			obj.cagePartsDetails = specData;
			template = "#cage_part_spec_contents_template";
		}
		obj.cagePartSpecs = this.cagePartSpecs;
		console.log(obj);
		//var new_cpanel = $(content).children(".collapse-panel[name=meshBlock]");
		var dat = _.template($(template).html(), obj);
		if($(cpanel).children(".collapse-panel-header").length > 0) {
			var new_cpanel = $("<div></div>").html(dat);
			$(cpanel).children(".collapse-panel-header").html($(new_cpanel).children(".collapse-panel-header").html());
			$(cpanel).children(".collapse-panel-body").html($(new_cpanel).children(".collapse-panel-body").html());
		} else {
			$(cpanel).html(dat);
		}
		if(spec)
			$(cpanel).find("#cagePartSpecSelect").val(spec);
	},
	renderChainLink: function(model) {
		var modelInfo = model.get("modelInfo");
		var obj = {chainLinkDetails: modelInfo.chainLinkDetails};
		var contentObj = $(this.modelIdToContentMapper[model.get('id')].content);
		var cpanel = $(contentObj).children(".collapse-panel[name=chainLink]");
		//var new_cpanel = $(content).children(".collapse-panel[name=meshBlock]");
		var dat = _.template($("#chain_link_contents_template").html(), modelInfo);
		if($(cpanel).children(".collapse-panel-header").length > 0) {
			var new_cpanel = $("<div></div>").html(dat);
			$(cpanel).children(".collapse-panel-header").html($(new_cpanel).children(".collapse-panel-header").html());
			$(cpanel).children(".collapse-panel-body").html($(new_cpanel).children(".collapse-panel-body").html());
		} else {
			$(cpanel).html(dat);
		}
	},
	renderWeldSide: function(model) {
		var modelInfo = model.get("modelInfo");
		var obj = {weldSideMeshDetails: modelInfo.weldSideMeshDetails};
		var contentObj = $(this.modelIdToContentMapper[model.get('id')].content);
		var cpanel = $(contentObj).children(".collapse-panel[name=weldSide]");
		//var new_cpanel = $(content).children(".collapse-panel[name=meshBlock]");
		var dat = _.template($("#weld_side_contents_template").html(), modelInfo);
		if($(cpanel).children(".collapse-panel-header").length > 0) {
			var new_cpanel = $("<div></div>").html(dat);
			$(cpanel).children(".collapse-panel-header").html($(new_cpanel).children(".collapse-panel-header").html());
			$(cpanel).children(".collapse-panel-body").html($(new_cpanel).children(".collapse-panel-body").html());
		} else {
			$(cpanel).html(dat);
		}
	},
	selectModelTab: function(modelId) {
		this.notifyHandlersFlag = false;
		this.modelIdToContentMapper[modelId].tab.trigger("click");
		this.notifyHandlersFlag = true;
	},
	disableEditFunctionality: function() {
		this.isEditable = false;
	}
});

var QuotationModelInfo = Backbone.Model.extend({
	initialize: function() {
		this.eventHandlers = new Array();
		this.view = new QuotationModelInfoView({el: this.get('container')});
		this.view.addEventHandler(this.viewEventHandler, this);
		this.modelsList = new ModelWithInfoList();
	},
	// event handlers
	viewEventHandler: function(event_type, event_data) {
		var type = event_type;
		var	data = event_data;
		console.log("in viewEventHandlers: "+ type);
		switch(type) {
			case "event_tabTileClicked":
			{
				type = "ModelInfoTabSelected";
			}
			break;
			case "event_tableDataKeyDown":
			{
				type = "ModelInfoEdited";
			}
		}
		this.notifyEvent(type, data);
	},
	// locally used functions
	notifyEvent: function(eventType, eventData) {
		if( this.eventHandlers[eventType] ) {
			var tmp = this.eventHandlers[eventType];
			tmp.handler.call(tmp.context, eventData);
		}
	},
	// interface funtions
	registerEventHandler: function(eventType, handler, context) {
		this.eventHandlers[eventType] = { handler: handler, context: context };
	},
	addModel: function(model) {
		this.modelsList.add(model);
		var specs = new Array();
		if(model.get('modelInfo').cagePartsDetails) {
			console.log(model.get('modelInfo'));
			var rows = model.get('modelInfo').cagePartsDetails.parts.rows;
			for(i in rows) {
				var id = rows[i].cagePartSpec.cagePartSpecificationId;
				var name = rows[i].cagePartSpec.cagePartSpecification;
				specs[id] = new Object({specId: id, specName: name});
			}
		}
		this.view.addModel(model, specs);
	},
	updateModel: function(model) {
		this.modelsList.add(model);
		this.view.updateModel(model);
	},
	getModel: function(modelId) {
		return this.modelsList.get(modelId);
	},
	selectModel: function(modelId) {
		this.view.selectModelTab(modelId);
	},
	disableEditFunctionality: function() {
		this.view.disableEditFunctionality();
	}
});