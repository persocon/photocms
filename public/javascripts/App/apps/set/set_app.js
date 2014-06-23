App.module("SetApp", function(SetApp, App, Backbone, Marionette, $, _){
	SetApp.Router = Marionette.AppRouter.extend({
		appRoutes: {
			"" : "listSetsHome",
			"set/:slug" : "showSet"
		}
	});

	var API = {
		listSetsHome: function(){
			SetApp.List.Controller.listSetsHome();
		},

		listSets: function(){
			SetApp.List.Controller.listSets();
		},

		showSet: function(slug){
			SetApp.Show.Controller.showSet(slug);
		}
	};

	App.on("set:list", function(){
		App.navigate("");
		API.listSetsHome();
	});

	App.on("set:show", function(slug){
		App.navigate("set/" + slug);
		API.showSet(slug);
	});

	App.addInitializer(function(){
		new SetApp.Router({
			controller: API
		});
	});
});