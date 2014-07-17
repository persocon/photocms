App.module("SetApp.List", function(List, App, Backbone, Marionette, $, _){

	
	List.Set = Marionette.ItemView.extend({
		tagName: "li",
		className: "set-list-item",
		template: Handlebars.compile($("#set-list-item").html()),
		initialize: function(){
			var that = this;
			$(window).on("resize", function(){
				that.setupItemHeight();
				that.setupSubMenuHeight();
			});
		},
		onRender: function(){
			this.setupItemHeight();
		},
		setupItemHeight: function(){
			this.$el.find('figure').height($(window).height());
		},
		setupSubMenuHeight: function(){
			App.trigger("submenu:height");
		},
		onClose: function(){
			$(window).off("resize",function(){
				that.setupItemHeight();
				that.setupSubMenuHeight();
			});
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