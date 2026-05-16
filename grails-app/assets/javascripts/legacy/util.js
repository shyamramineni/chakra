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


