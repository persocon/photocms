App.module("CategoryApp", function(CategoryApp, App, Backbone, Marionette, $, _){
	CategoryApp.Router = Marionette.AppRouter.extend({
		appRoutes: {
			"category/:slug" : "listCategory"
		}
	});

	var API = {
		listCategory: function(slug){
			CategoryApp.List.Controller.listCategory(slug);
		}
	};


	App.on("category:list", function(slug){
		App.navigate("category/" + slug);
		API.listCategory(slug);
	});

	App.addInitializer(function(){
		new CategoryApp.Router({
			controller: API
		});
	});
});