App.module("Common.Views", function(Views, App, Backbone, Marionette, $, _){
	Views.MissingPage = Marionette.ItemView.extend({
		template: "#missing-page"
	});
	
	Views.Loading = Marionette.ItemView.extend({
		template: "#loading-view"
	});

	Views.Layout = Marionette.Layout.extend({
		template: Handlebars.compile($("#main-layout").html()),
		regions: {
			panelRegion: "#panel-region",
			contentRegion: "#contents-region"
		}
	});

	Views.Panel = Marionette.ItemView.extend({
		className: 'wrap',
		template: Handlebars.compile($("#app-panel").html()),
		events: {
			'click a.toggle_menu' : 'toggleMenu',
			'touchstart a.toggle_menu' : 'toggleMenu'
		},
		toggleMenu: function(event){
			event.preventDefault();
			event.stopPropagation();
			App.trigger("header:showMenu");
		},
		onRender: function(){
			$('body').removeClass('open_menu');
		}
	});

});