App.module("PageApp.Show", function(Show, App, Backbone, Marionette, $, _){
	Show.Page = Marionette.ItemView.extend({
		template: Handlebars.compile($("#page-view").html())
	});
});