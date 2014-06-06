App.module("PageApp", function(PageApp, App, Backbone, Marionette, $, _){
	PageApp.Router = Marionette.AppRouter.extend({
		appRoutes: {
			"page/:slug" : "showPage"
		}
	});

	var API = {
		showPage: function(slug){
			PageApp.Show.Controller.showPage(slug);
		}
	};

	App.on("page:show", function(slug){
		App.navigate("page/" + slug);
		API.showPage(slug);
	});

	App.addInitializer(function(){
		new PageApp.Router({
			controller: API
		});
	});
});