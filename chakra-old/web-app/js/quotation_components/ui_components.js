// JavaScript Document
var TabbedPanel = Backbone.View.extend( {
	initialize: function() {
		this.currentSelection = {
			id:null,
			tab:null,
			tabContent:null
		};
		this.countEditContext = new Array();
		this.isEditable = true;
		this.render();
		console.log("View: TabbedPanel initialized!");
	},
	iseditable: function(flag) {
		this.isEditable = flag;
	},
	render: function() {
		var temp = _.template($("#tabbed_panel_content").html(),{});
		this.$el.html(temp);
	},
	events: {
		"click .tab-tile":"doSelectTab",
		"click .collapse-panel-header":"toggleCollapse",
		"mouseenter .table-data":"mouseenter_Action",
		"mouseleave .table-data":"mouseleave_Action",
		"dblclick .table-data":"dblclick_Action",
		"keydown .table-data .table-input-element":"keydown_Action"
	},
	mouseenter_Action: function(e) {
		var element = e.currentTarget;
		if(!$(element).hasClass("table-data-selected"))
			$(element).addClass("table-data-highlighted");
	},
	mouseleave_Action: function(e) {
		var element = e.currentTarget;
		if(!$(element).hasClass("table-data-selected"))
			$(element).removeClass("table-data-highlighted");
	},
	dblclick_Action: function(e) {
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
				
				/*var bkp = this.countEditContext[cageDesign].backupCount = $(element).children(".table-data-itemcount").text();
				var text = '<input type="text" class="table-input-element" value="'+bkp+'" />';
				$(element).children(".table-data-itemcount").html(text);
				$(element).find(".table-input-element").focus();*/
			}
		}
	},
	keydown_Action: function(e) {
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
			reqobj.quotationId = this.quotation.get('id');
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
			comm.sendRequest(req, requestUrl, this.costUpdateResponse, this);
			e.preventDefault();
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
	costUpdateResponse: function(status, data, jqXHR) {
		if(status == "Success")
		{
			var elem = this.changedBlock;
			var json = $.parseJSON(jqXHR.responseText);
			switch(json.responseCode)
			{
				case "CAGEOK":
				{
					var html = _.template($("#cage_part_contents_template").html(), json.responseData);
					html = $(html);
					console.log(html);
					$(elem).children(".collapse-panel-header").html($(html).eq(0).html());
					$(elem).children(".collapse-panel-body").html($(html).eq(2).html());
				}
				break;
				case "MESHOK":
				{
					var html = _.template($("#mesh_part_contents_template").html(), json.responseData);
					html = $(html);
					console.log(html);
					$(elem).children(".collapse-panel-header").html($(html).eq(0).html());
					$(elem).children(".collapse-panel-body").html($(html).eq(2).html());
				}
				break;
				case "CHAINOK":
				{
					var html = _.template($("#chain_link_contents_template").html(), json.responseData);
					html = $(html);
					console.log(html);
					$(elem).children(".collapse-panel-header").html($(html).eq(0).html());
					$(elem).children(".collapse-panel-body").html($(html).eq(2).html());
				}
				break;
				case "WELDOK":
				{
					var html = _.template($("#weld_side_contents_template").html(), json.responseData);
					html = $(html);
					console.log(html);
					$(elem).children(".collapse-panel-header").html($(html).eq(0).html());
					$(elem).children(".collapse-panel-body").html($(html).eq(2).html());
				}
				break;
			}
			/*var resp = $.parseJSON(jqXHR.responseText);
			var element = this.$("div.tab-tile-content[name="+resp.responseData.modelId+"]").find("td.table-sheet-id[name="+resp.responseData.id+"]").eq(0).parents(".table-data").eq(0);
			$(element).children(".table-data-itemprice").text(resp.responseData.cost);*/
			
		}
	},
	addModel: function(response) {
		if(response.modelInfo.meshPartsDetails)
		{
			var tab = _.template($("#tab_tile_template").html(), response);
			//console.log("Tab-html:");
			this.$(".tabs-holder").eq(0).append($(tab));
			//console.log("Tab-body-content:");
			var content = _.template($("#tab_body_template").html(), response);
			//console.log(content);
			this.$(".tabs-content-holder").eq(0).append($(content));
		}
	},
	toggleCollapse: function(e) {
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
	doSelectTab: function(e) {
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
		this.quotation.modelGridView.triggerRow(id);
	},
	triggerTab: function(id) {
		var element = this.$(".tab-tile[name="+id+"]");//.trigger("click");
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
	}
});
