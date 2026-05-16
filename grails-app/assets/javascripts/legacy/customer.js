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
		console.log('Model: Customer initialized ' + this.get('mobile'));
	}
});

var CustomerList = Backbone.Collection.extend({
	model: Customer
});

var CustomerTileView = Backbone.View.extend({
	initialize: function() {
		this.EventHandlers = new Array();
		this.shadowText = new Array();
		this.flagData = new Array();
	},
	serialize: function() {
		return {
			"custname": this.getTextVal("#custname-input"),
			"mobile": this.getTextVal("#mobile-input"),
			"compname": this.getTextVal("#companyname-input"),
			"address": this.getTextVal("#address-input"),
			"email": this.getTextVal("#email-input"),
			"phone": this.getTextVal("#phoneno-input"),
			"fax": this.getTextVal("#fax-input"),
			"comments": this.getTextVal("#comments-input"),
		};
	},
	getTextVal: function(id) {
		if(this.$(id).val() == this.shadowText[id])
			return;
		else
			return this.$(id).val();
	},
	validate_field: function(element, regexp, errmsg) {
		if(! $(element).val().match(regexp))
		{
			$(element).addClass("textfield_error");
			alert(errmsg);
			return false;
		}
		else
			$(element).removeClass("textfield_error");
		return true;
	},
	fieldChanged: function(id) {
		if(this.$(id).val() == this.shadowText[id])
			return false;
		return true;
	},
	validate: function() {
		if(! this.validate_field($("#mobile-input"), "^[0-9][0-9]*$", "enter a number"))
		{
			return false;
		}
		if(this.extrafields)
		{
			if( this.fieldChanged("#email-input") && !this.validate_field($("#email-input"), "^[a-zA-Z0-9._]+@[a-zA-Z0-9._]+\.[a-zA-Z0-9._]+$", "enter valid email address"))
				return false;
		}
		return true;
	},
	events: {
		"click #search-btn":"event_searchBtnClicked",
		"click #add-btn":"event_addBtnClicked",
		"click #addwithaddl-btn":"event_addWithAddlFieldsBtnClicked",
		"click input[type=radio]":"event_radioBtnSelected"
	},
	event_searchBtnClicked: function(e) {
		if(true) //this.validate("search"))
		{
			this.notifyEventToHandlers("event_search", this.serialize());
			/*this.customerRequest = new CustomerRequest({url:$("#customer_search-url").val()});
			this.customerRequest.registerCallback(this.doSearchCallback, this);
			var model = new Customer(this.serialize());
			this.customerRequest.searchCustomer(model.toJSON());*/
		}
	},
	event_addBtnClicked: function(e) {
		if(this.validate("add")) {
			this.notifyEventToHandlers("event_add", this.serialize());
		}
	},
	event_addWithAddlFieldsBtnClicked: function(e) {
		this.extrafields = true;
		this.$("[name=extra]").css({"display":"table-row"});
		this.$("#addwithaddl-btn").css({display:"none"});
	},
	event_radioBtnSelected: function(e) {
		var id = $(e.currentTarget).attr("name");
		this.notifyEventToHandlers("event_searchResultSelected", id);
	},
	render: function(templateId, params) {
		var template = _.template($(templateId).html(), params);
		this.$el.html(template);
	},
	setShadowFunctions: function() {
		this.setShadowFunction("#companyname-input","Company Name");
		this.setShadowFunction("#custname-input","Customer Name");
		this.setShadowFunction("#mobile-input","Mobile No");
		this.setShadowFunction("#address-input","Address");
		this.setShadowFunction("#email-input","Email ID");
		this.setShadowFunction("#phoneno-input","Phone Number");
		this.setShadowFunction("#fax-input","Fax");
		this.setShadowFunction("#comments-input","Comments");
	},
	setTaxSelection: function(taxid) {
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
	setShadowFunction: function(id, shadowText) {
		this.shadowText[id] = shadowText;
		$(id).val(shadowText).bind("focusin",this,function(e) {
			var context = e.data;
			if(!context.flagData[id])
				$(id).val("").removeClass("textfield-initial");
		});
		$(id).focusout(this, function(e) {
			var context = e.data;
			if($(id).val() == "")
			{
				$(id).val(shadowText).addClass("textfield-initial");
				context.flagData[id] = false;
			}
			else
				context.flagData[id] = true;
		});
	},
	
	// 
	fillSearchResults: function(customersList) {
		console.log("fillSearchResults called ->");
		console.log(customersList);
		this.$(".customer-content-container-results-area table").find(".search-result").each(function(index, element) {
			$(element).remove();
		});
		customersList.each(function (element, index, list) {
			var temp = _.template($("#customer_search_result_entry").html(), element.toJSON());
			this.$(".customer-content-container-results-area table").append($(temp));
		});
		this.undelegateEvents();
		this.delegateEvents();
	},
	showCustomer: function(customer) {
		console.log("showCustomer called ->");
		console.log(customer);
		this.render("#customer_tile_content-final", customer.toJSON());
	}
});

var CustomerTile = Backbone.Model.extend({
	initialize: function() {
		this.eventHandlers = new Array();
		this.selectedCustomer = null;
		this.customerTileView = new CustomerTileView({el: this.get('container')});
		this.customerTileView.addEventHandler(this.viewEventHandler, this);
		
		this.renderTemplate_search = "#customer_tile_content-initial";
		
		this.customerTileView.render(this.renderTemplate_search);
		this.customerTileView.setShadowFunctions();
		
		var taxid = $("#quot_plan_taxation").val();
		$("#taxation").val(taxid);
		
		this.customerTileView.setTaxSelection(taxid);
	},
	viewEventHandler: function(event_type, event_data) {
		switch(event_type) {
			case "event_search":
			{
				this.doCustomerSearch(event_data);
			}
			break;
			case "event_searchResultSelected":
			{
				var cust = this.doCustomerSelect(event_data);
				this.notifyEvent("CustomerSelected", cust);
			}
			break;
			case "event_add":
			{
				var cid = this.doCustomerAdd(event_data);
			}
			break;
		}
	},
	serverRequestResponseHandler: function(responseType, jqXHR) {
		console.log("serverRequestResponseHandler:" + responseType);
		switch(responseType) {
			case "CustomerSearch":
			{
				var resp = $.parseJSON(jqXHR.responseText);
				var custList = resp.responseData;
				this.customerResults = new CustomerList(custList);
				this.customerTileView.fillSearchResults(this.customerResults);
			}
			break;
			case "CustomerAdd":
			{
				var resp = $.parseJSON(jqXHR.responseText);
				var custList = resp.responseData;
				this.customerResults = new CustomerList(custList);
				this.customerTileView.fillSearchResults(this.customerResults);
				var cid = custList[0].id;
				var cust = this.doCustomerSelect(cid);
				this.notifyEvent("CustomerSelected", cust);
			}
			break;
		}
	},
	doCustomerSearch: function(search_params) {
		console.log("calling doCustomerSearch ->");
		console.log(search_params);
		var request = new ServerRequest({"requestType":"CustomerSearch", requrl:$("#customer_search-url").val()});
		var req = "requestType=CustomerSearchRequest&requestData=" + JSON.stringify(search_params);
		request.sendRequestAndNotify(req, this.serverRequestResponseHandler, this);
	},
	doCustomerSelect: function(id) {
		console.log("calling doCustomerSelect ->");
		console.log(id);
		console.log("selected customer");
		this.selectedCustomer = this.customerResults.get(id);
		console.log(this.selectedCustomer);
		this.customerTileView.showCustomer(this.selectedCustomer);
		return this.selectedCustomer;
	},
	doCustomerAdd: function(add_params) {
		console.log("calling doCustomerAdd");
		var req = "requestData=" + JSON.stringify(add_params)+"&requestType=CustomerAddRequest";
		var request = new ServerRequest({"requestType":"CustomerAdd", requrl:$("#customer_add-url").val()});
		request.sendRequestAndNotify(req, this.serverRequestResponseHandler, this);
	},
	setCustomer: function(cust) {
		this.selectedCustomer = new Customer(cust);
		this.customerTileView.showCustomer(this.selectedCustomer);
	},
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