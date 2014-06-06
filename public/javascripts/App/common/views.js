App.module("Common.Views", function(Views, App, Backbone, Marionette, $, _){
	Views.MissingPage = Marionette.ItemView.extend({
		template: "#missing-page"
	});
	Views.Loading = Marionette.ItemView.extend({
		template: "#loading-view"
	});
});