// JavaScript Document

var QuotationRelatedInformation = Backbone.Model.extend({
	defaults:{
		quotation: null,
		status: null,
		createdby: null,
		createddate: null,
		enquiry: null,
		comments: null
	},
	initialize: function() {
		console.log('Model:  initialized');
	}
});

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