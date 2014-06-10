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
		template: Handlebars.compile($("#app-panel").html()),
		events: {
			'click a.toggle_menu' : 'toggleMenu'
		},
		toggleMenu: function(event){
			event.preventDefault();
			event.stopPropagation();
			if($('body').hasClass('open_menu')){
				$('#main-region').removeAttr('style');
			}else{
				$('#main-region').height(screen.height - 40);
			}
			$('body').toggleClass('open_menu');
		}
	});

});