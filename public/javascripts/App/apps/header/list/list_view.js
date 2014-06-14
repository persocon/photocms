App.module("HeaderApp.List", function(List, App, Backbone, Marionette, $, _){
	List.Header = Marionette.ItemView.extend({
		template: Handlebars.compile($("#header-link").html()),
		tagName: "nav",
		events: {
			"click a.internal_link" : "navigate",
			"click .open-submenu" : "openSubmenu",
			"click .close-submenu" : "closeSubmenu",
			"click .header-close" : "closeMenu"
		},
		navigate: function(event){
			event.preventDefault();
			var type, slug;
			type = $(event.currentTarget).attr('data-type');
			slug = $(event.currentTarget).attr('data-slug');

			$('body').removeClass('open_menu');

			this.trigger("header:navigate", {type: type, slug: slug});
		},
		closeMenu: function(event){
			event.preventDefault();
			event.stopPropagation();
			this.$el.parent().fadeOut(300, function(){
				$('body').removeClass('open_menu');
			});
		},
		openMenu: function(){
			console.log()
			this.$el.parent().fadeIn(300, function(){
				$('body').addClass('open_menu');
			});
		},
		openSubmenu: function(event){
			event.preventDefault();
			event.stopPropagation();
			$(event.currentTarget).next('.submenu').show(0, function(){
				$(event.currentTarget).closest('ul').addClass('translated');
			});
		},
		closeSubmenu: function(event){
			event.preventDefault();
			event.stopPropagation();
			$(event.currentTarget).closest('ul.translated').removeClass('translated');
			setTimeout(function(){
				$(event.currentTarget).closest('.submenu').hide();
			},300);
		}
	});
});