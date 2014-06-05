App.module("SetApp", function(SetApp, App, Backbone, Marionette, $, _){
	SetApp.Router = Marionette.AppRouter.extend({
		appRoutes: {
			"" : "listSets",
			"set/:slug" : "showSet"
		}
	});

	var API = {
		listSets: function(){
			SetApp.List.Controller.listSets();
		},

		showSet: function(slug){
			SetApp.Show.Controller.showSet(slug);
		}
	};

	App.on("set:list", function(){
		App.navigate("");
		API.listSets();
	});

	App.on("set:show", function(slug){
		App.navigate("set/" + slug);
		API.showContact(id);
	});

	App.addInitializer(function(){
		new SetApp.Router({
			controller: API
		});
	});
});