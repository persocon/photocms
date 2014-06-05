App.module("HeaderApp.List", function(List, App, Backbone, Marionette, $, _){
	List.Header = Marionette.ItemView.extend({
		template: Handlebars.compile($("#header-link").html()),
		tagName: "ul",
		events: {
			"click a" : "navigate"
		},
		navigate: function(event){
			event.preventDefault();
			this.trigger("navigate", this.model);
		}
	});
});