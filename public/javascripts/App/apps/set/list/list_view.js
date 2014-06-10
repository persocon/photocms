App.module("SetApp.List", function(List, App, Backbone, Marionette, $, _){

	
	List.Set = Marionette.ItemView.extend({
		tagName: "li",
		template: Handlebars.compile($("#set-list-item").html())
	});

	List.Sets = Marionette.CompositeView.extend({
		tagName: "div",
		template: Handlebars.compile($("#set-list").html()),
		itemView: List.Set,
		itemViewContainer: "ul"
	});

});