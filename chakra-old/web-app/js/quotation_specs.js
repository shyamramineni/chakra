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

var QuotationSpecsTileView = Backbone.View.extend({
	initialize: function() {
		this.EventHandlers = new Array();
		console.log("Model: QuotationSpecsTileView Initialized");
	},
	serialize: function() {
		return {
			"cageLength": this.$("#cage_length").val(),
			"noOfCuttingsInShed": this.$("#cage_cuttings").val(),
			"noOfSheds": this.$("#shed_count").val(),
			"fulls": this.$("#fulls_count").val(),
			"halfs": this.$("#halfs_count").val(),
			"tiers": this.$("#tiers_count").val()
		};
	},
	events: {
		"click #quotation_specs_submit-btn":"event_submitBtnClicked"
	},
	event_submitBtnClicked: function(e) {
		console.log("event_submitBtnClicked called");
		this.notifyEventToHandlers("event_submitBtnClicked", this.serialize());
	},
	render: function(templateId, params) {
		var template = _.template($(templateId).html(), params);
		this.$el.html(template);
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
	}
});

var QuotationSpecsTile = Backbone.Model.extend({
	initialize: function() {
		this.eventHandlers =  new Array();
		this.view = new QuotationSpecsTileView({el: this.get('container')});
		this.view.addEventHandler(this.viewEventHandler, this);
		this.view.render("#specs_tile_content-initial");
	},
	viewEventHandler: function(event_type, event_data) {
		var data = event_data;
		console.log("in viewEventHandler: "+event_type);
		switch(event_type) {
			case "event_submitBtnClicked":
			{ 
				
			}
			break;
		}
		this.notifyEvent(event_type, data);
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
	showSpecs: function(specs) {
		this.view.render("#specs_tile_content-final", specs);
	}
});