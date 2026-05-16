// JavaScript Document
var Customer = Backbone.Model.extend({
	defaults:{
		"id": null,
		"custname": null,
		"mobile": null,
		"fax": null,
		"email": null,
		"phone": null,
		"compname": null,
		"comments": null,
		"address": {
			country: null,
			state: null,
			city: null,
			street: null
		}
	},
	initialize: function() {
		console.log('Model: Customer initialized ');
	}
});

var CustomerList = Backbone.Collection.extend({
	model: Customer
});

var CustomerRequest = Backbone.Model.extend({
	defaults: {
		"url" : null,
		"searchResults": null
	},
	registerCallback: function(func, context) {
		this.externalCallbackFunction = func;
		this.set({ 'callbackContext': context });
	},
	searchCustomer: function(searchParams) {
		var req = "requestType=CustomerSearchRequest&requestData=" + JSON.stringify(searchParams);
		console.log("Customer Request: "+req);
		var url = this.get('url');
		var comm = new Communicator;
		comm.sendRequest(req, url, this.searchCustomerCallback, this); 
	},
	searchCustomerCallback: function(stat, data, jqXHR)
	{
		if(stat == "Success")
		{
			json = $.parseJSON(jqXHR.responseText);
			var list = new CustomerList(json.responseData);
			this.set({searchResults: list});
			this.externalCallbackFunction.call(this.get('callbackContext'),this.get('searchResults'));
		}
	},
	addCustomer: function(params) {
		var req = "requestData=" + JSON.stringify(params)+"&requestType=CustomerAddRequest";
		var url = this.get('url');
		var comm = new Communicator;
		comm.sendRequest(req, url, this.addCustomerCallback, this); 
	},
	addCustomerCallback: function(stat, data, jqXHR)
	{
		if(stat == "Success")
		{
			json = $.parseJSON(jqXHR.responseText);
			var list = new CustomerList(json.responseData);
			this.set({addResult: list});
			this.externalCallbackFunction.call(this.get('callbackContext'),this.get('addResult'));
		}
	}
});
