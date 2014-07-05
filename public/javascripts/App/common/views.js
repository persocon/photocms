App.module("Common.Views", function(Views, App, Backbone, Marionette, $, _){
	Views.MissingPage = Marionette.ItemView.extend({
		template: "#missing-page"
	});
	
	Views.Loading = Marionette.ItemView.extend({
		template: "#loading-view",
		initialize: function(options){
			var options = options || {};
			this.title = options.title || "Loading Data";
			this.message = options.message || "Please wait, data is loading.";
		},
		serializeData: function(){
			return {
				title: this.title,
				message: this.message
			}
		},
		onShow: function(){
			var opts = {
				lines: 13,
				length: 20,
				width: 10,
				radius: 30,
				corners: 1,
				rotate: 0,
				direction: 1,
				color: "#FFF",
				speed: 1,
				trail: 50,
				shadow: false,
				hwaccel: true,
				className: "spinner",
				zIndex: 2e9,
				top: "30px",
				left: "auto"
			};
			$("#spinner").spin(opts);
		}
	});

	Views.Layout = Marionette.Layout.extend({
		template: Handlebars.compile($("#main-layout").html()),
		regions: {
			panelRegion: "#panel-region",
			contentRegion: "#contents-region",
			footerRegion: "#footer-region"
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
			$(window).scroll(this.setupOpacity);
		},
		setupOpacity: function(){
			var oVal = $(window).scrollTop() / 240;
			$('#panel-region').css("background", 'rgba(0,0,0,'+oVal+')');
		}
	});

	Views.Footer = Marionette.ItemView.extend({
		template: "#footer-view",
		className: 'footer-wrap',
		events: {
			'click .go-to-top': 'goTop'
		},
		goTop: function(event){
			event.preventDefault();
			event.stopPropagation();
			$('body,html').animate({
				scrollTop: 0
			}, 800);
		}
	});

});