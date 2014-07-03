App.module("SetApp.Show", function(Show, App, Backbone, Marionette, $, _){
	Show.Set = Marionette.ItemView.extend({
		template: Handlebars.compile($("#set-view").html()),
		className: "set",
		initialize: function(){
			if( _.isEmpty(this.model.get('featured_image')) ){
				this.$el.addClass("not-featured");
			}
		}
	});
});