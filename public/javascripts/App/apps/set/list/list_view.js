App.module("SetApp.List", function(List, App, Backbone, Marionette, $, _){

	
	List.Set = Marionette.ItemView.extend({
		tagName: "li",
		className: "set-list-item",
		template: Handlebars.compile($("#set-list-item").html())
	});

	List.SetHome = Marionette.ItemView.extend({
		tagName: "li",
		className: "set-list-item",
		template: Handlebars.compile($("#set-list-item-home").html())
	});

	List.Sets = Marionette.CompositeView.extend({
		tagName: "div",
		className: "sets",
		template: Handlebars.compile($("#set-list").html()),
		itemView: List.Set,
		itemViewContainer: "ul"
	});

});