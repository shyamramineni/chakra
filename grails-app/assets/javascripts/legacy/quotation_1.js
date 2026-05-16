// JavaScript Document

var Communicator = Backbone.Model.extend({
	channel : new Array(),
	defaults: {
		"requestData" : null,
		"requestUrl" : null,
		"responseCallback" : null,
		"channel": "1",
		"state" : "Idle"
	},
	initialize: function() {
		this.on("change:channel", function(eventName) {
			if(!this.channel[this.get('channel')])
				this.channel[this.get('channel')] = {state: "Idle", callbacks: []};
			else
			{
				this.set({"state": this.channel[this.get('channel')].state});
			}
		});
		this.on("change:state", function(eventName) {
			this.channel[this.get('channel')].state = this.get('state');
			for(var func in this.channel[this.get('channel')].callbacks)
			{
				this.channel[this.get('channel')].callbacks[func](this);
			}
		});
		this.trigger("change:channel");
		console.log("Model: Communicator Initialized!");
	},
	sendRequest: function(req, url, respCallback, context) {
		console.log("RequestUrl: "+url);
		console.log("Request: " + req);
		this.set({"state": this.channel[this.get('channel')].state},{silent:true});
		if(this.get("state") == "Idle")
		{
			this.set({ state : "Working" });
			this.set({ requestData : req });
			this.set({ requestUrl : url });
			this.set({ responseCallback : respCallback });
			this.set({callbackContext: context});
			$.ajax({
				type: 'POST',
				url: this.get('requestUrl'),
				context: this,
				contentType:"application/x-www-form-urlencoded",
				data: this.get('requestData'),
				success: this.successCallback,
				error: this.errorCallback,
				async: true
			});
		}
		else
			return null;
	},
	successCallback: function(data, textStatus, jqXHR) {
		console.log("response: "+jqXHR.responseText);
		var context = this.get('callbackContext');
		this.set({ state : "Idle" });
		this.get('responseCallback').call(context,"Success", data, jqXHR);
	},
	errorCallback: function(jqXHR, textStatus, errorThrown) {
		console.log(textStatus);
		this.set({ state : "Idle" });
		this.get('responseCallback')("Fail", errorThrown, jqXHR);
	}
});


var Loader = Backbone.Router.extend({
	routes: {
		"qid/:id":"startLoaded",
		"*path":"startNormal"
	},
	startNormal: function(path) {
		//this.quotation = new Quotation();
		this.customerView = new CustomerTile({"container": "#customer_tile"});
		/*this.customerView.quotation = this.quotation;
		this.quotation.customerView = this.customerView;*/
	},
	startLoaded: function(id) {
		this.quotation = new Quotation({startMode: "loader"});
		this.quotation.set({"id":id});
		var reqdata = {
			quotationId : id
		};
		var req = "requestType=QuotationLoaderRequest&requestData=" + JSON.stringify(reqdata);
		var comm = new Communicator;
		comm.sendRequest(req, $("#quotation_loader_request-url").val(), this.startLoadedCallback, this);
	},
	startLoadedCallback: function(status, data, jqXHR) {
		var resp = $.parseJSON(jqXHR.responseText);
		resp = resp.responseData;
		this.quotation.set({quotationId: resp.quotInfo.id});
		this.quotation.quotationMode = "Loader";
		if(resp.quotInfo.enquiry != "")
		{
			this.quotation.sourcePage = "Enquiry";
		}
		else if(! resp.specsInfo)
		{
			this.quotation.sourcePage = "QuotationCart";
		}
		else
		{
			this.quotation.sourcePage = "QuotationPlanner";
		}
		console.log("Source Page: "+ this.quotation.sourcePage);
		
		var template = _.template($("#customer_tile_content-final").html(), resp.custInfo);
		$("#customer_tile").html(template);
				
		this.quotation.customerCreated(resp.custInfo.id, new Customer(this.custInfo));
		this.quotation.taxId = resp.taxation;
		this.quotation.quotInfo = new QuotationRelatedInformation(resp.quotInfo);
		
		resp.quotInfo.taxation = resp.taxation;
		template = _.template($("#quotation_info_tile_content").html(), resp.quotInfo);
		$("#quotation_info_tile").html(template);
		if(this.quotation.sourcePage != "QuotationCart")
		{
			console.log(resp.specsInfo);
			template = _.template($("#specs_tile_content-final").html(), resp.specsInfo);
			$("#quotation_info_tile_init").html(template);
		}
		
		if(this.quotation.sourcePage != "QuotationCart")
		{
			this.quotation.afterSpecsSubmit(true);
			//this.quotation.modelGridView.quotation = this.quotation;
			this.quotation.modelGridView.registerModelAddCallback();
			this.quotation.modelGrid = new ModelGrid({"context":this.quotation});
		}
		
		for(var i in resp.quotationModels)
		{
			this.quotation.addModel(resp.quotationModels[i]);
		}
		
	}
});

$(function() {
	/*var loader = new Loader();
	Backbone.history.start();*/
	this.customerView = new CustomerTile({"container": "#customer_tile"});
	/*var specsView = new SpecsView({el: "#quotation_info_tile_init"});
	specsView.setQuotation(quotation);
	specsView.render();*/
});
