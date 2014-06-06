App.module("TagApp", function(TagApp, App, Backbone, Marionette, $, _){
	TagApp.Router = Marionette.AppRouter.extend({
		appRoutes: {
			"tag/:slug" : "listTag"
		}
	});

	var API = {
		listTag: function(slug){
			TagApp.List.Controller.listTag(slug);
		}
	};


	App.on("tag:list", function(slug){
		App.navigate("tag/" + slug);
		API.listTag(slug);
	});

	App.addInitializer(function(){
		new TagApp.Router({
			controller: API
		});
	});
});