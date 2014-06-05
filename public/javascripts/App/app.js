var App = new Marionette.Application();

App.addRegions({
	headerRegion: "#header-region",
	mainRegion: "#main-region"
});

App.navigate = function(route, options){
	options || (options = {});
	Backbone.history.navigate(route, options);
};

App.getCurrentRoute = function(){
	return Backbone.history.fragment;
}

App.on("initialize:after", function(){
	if(Backbone.history){
		Backbone.history.start();

		if(this.getCurrentRoute() === ""){
			// var fetchingContacts = App.request("header:entities");
			// $.when(fetchingContacts).done(function(contacts){
			// 		console.log(contacts);
			// });
			
			var fetchingContact = App.request("header:entity", "main");
			$.when(fetchingContact).done(function(contact){
					console.log(contact)
			});
			
		}
	}
});