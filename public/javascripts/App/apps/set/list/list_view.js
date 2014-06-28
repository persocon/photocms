App.module("SetApp.List", function(List, App, Backbone, Marionette, $, _){

	
	List.Set = Marionette.ItemView.extend({
		tagName: "li",
		className: "set-list-item",
		template: Handlebars.compile($("#set-list-item").html()),
		onRender: function(){
			//SETUP HEIGHT
			this.$el.find('figure').height($(window).height());
		}
	});

	List.Sets = Marionette.CompositeView.extend({
		tagName: "div",
		className: "sets",
		template: Handlebars.compile($("#set-list").html()),
		itemView: List.Set,
		itemViewContainer: "ul"
	});

});