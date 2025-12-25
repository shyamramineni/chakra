// JavaScript Document

var QuotationSpecs = Backbone.Model.extend({
	defaults: {
		"cageLength":0,
		"noOfCuttingsInShed":0,
		"noOfSheds":0,
		"fulls":0,
		"halfs":0,
		"tiers":0
	},
	initialize: function() {
		console.log("Model: QuotationSpecs Initialized");
	}
});

var QuotationInfoTileView = Backbone.View.extend({
	initialize: function() {
		console.log("Model: QuotationSpecsTileView Initialized");
		this.EventHandlers = new Array();
	},
	events: {
		"change #enquiry_taxation_select_field":"event_taxSelectChanged"
	},
	// event handlers
	event_taxSelectChanged: function(e) {
		var t = $(e.currentTarget);
		var taxVal = $(t).val();
		var taxName = $(t).children("option[value="+taxVal+"]").text();
		$("#enquiry_taxation_select_field").parent().html(taxName);
		this.notifyEventToHandlers("event_taxSelectChanged", {taxName: taxName, taxVal: taxVal});
	},
	// local calls
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
	
	render: function(templateId, params) {
		var template = _.template($(templateId).html(), params);
		this.$el.html(template);
	}
});

var QuotationInfoTile = Backbone.Model.extend({
	initialize: function() {
		this.eventHandlers = new Array();
		this.view = new QuotationInfoTileView({el: this.get('container')});
		//this.view.render("#quotation_info_tile_content",$.parseJSON('{"id":"1234", "quotation":"QT", "status":"REALIZED", "createdby":"tej", "createddate":"today","enquiry":"asd","comments":"Quotation created by tej", "taxation":"none"}'));
		this.view.addEventHandler(this.viewEventHandler, this);
	},
	showQuotInfo: function(info, showTaxOptions) {
		if(showTaxOptions) {
			info.taxation = '<select id="enquiry_taxation_select_field">' 
														+ $("#taxation_options_template").html() 
														+ '</select>';
		}
		this.view.render("#quotation_info_tile_content", info);
	},
	
	// local func
	viewEventHandler: function(event_type, event_data) {
		console.log("in viewEventHandler: "+event_type);
		var data = event_data;
		var type = event_type;
		switch(event_type) {
			case "event_taxSelectChanged":
			{
				type = "TaxSelected";
				//this.notifyEvent(event_type, event_data);
			}
			break;
		}
		this.notifyEvent(type, data);
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