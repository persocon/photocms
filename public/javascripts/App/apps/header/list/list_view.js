App.module("HeaderApp.List", function(List, App, Backbone, Marionette, $, _){
	List.Header = Marionette.ItemView.extend({
		template: Handlebars.compile($("#header-link").html()),
		tagName: "ul",
		events: {
			"click a.internal_link" : "navigate"
		},
		navigate: function(event){
			event.preventDefault();
			var type, slug;
			type = $(event.currentTarget).attr('data-type');
			slug = $(event.currentTarget).attr('data-slug');

			this.trigger("header:navigate", {type: type, slug: slug});
		}
	});
});