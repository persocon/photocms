App.module("SetApp.Show", function(Show, App, Backbone, Marionette, $, _){
	Show.Set = Marionette.ItemView.extend({
		template: Handlebars.compile($("#set-view").html())
	});
});