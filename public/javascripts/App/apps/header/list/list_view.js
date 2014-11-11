App.module("HeaderApp.List", function(List, App, Backbone, Marionette, $, _){
	List.Header = Marionette.ItemView.extend({
		template: Handlebars.compile($("#menu-view").html()),
		tagName: "nav",
		events: {
			"click a.internal_link" : "navigate",
			"click .open-submenu" : "openSubmenu",
			"click .close-submenu" : "closeSubmenu",
			"click .header-close" : "closeMenu"
		},
		initialize: function(){
			App.on("submenu:height", this.setupSubMenuHeight);
		},
		navigate: function(event){
			event.preventDefault();
			var type, slug;
			type = $(event.currentTarget).attr('data-type');
			slug = $(event.currentTarget).attr('data-slug');
			
			
			this.closeIfMobile(event);

			this.trigger("header:navigate", {type: type, slug: slug});
		},
		closeIfMobile: function(event){
			this.closeMenu(event);
			this.removeTranslated();
		},
		closeMenu: function(event){
			event.preventDefault();
			event.stopPropagation();
			var self = this;
			this.$el.parent().fadeOut(300, function(){
				$('body').removeClass('open_menu');
				self.$el.removeClass("is-mobile");
			});
		},
		removeTranslated: function(){
			this.$('.translated').each(function(){
				$(this).removeClass('translated');
			});	
			this.$('.submenu').each(function(){
				$(this).fadeOut(0);
			})
		},
		openMenu: function(){
			this.$el.parent().stop(true,true).fadeToggle(300, function(){
				$('body').toggleClass('open_menu');
			});
			if(this.getOS().OS != 'unknown'){
				this.$el.addClass("is-mobile");
			}

		},
		setupSubMenuHeight: function(){
			var windowHeight = parseInt($(window).height()) - 39
			self = this;

			var submenu_setup = function(submenu){
				if($(submenu).height() > windowHeight){
					$(submenu)
						.addClass("has-overflow-fix")
						.css({maxHeight: windowHeight+"px"});
				}else{
					$(submenu)
						.removeClass("has-overflow-fix")
						.css({maxHeight: ""});
				}
			}

			if(!_.isEmpty(arguments)){
				var submenu = arguments[0][0];
				submenu_setup(submenu);
			}else{
				submenu_setup($('#header-region nav.is-mobile').find('.submenu:visible'));
			}

		},
		openSubmenu: function(event){
			event.preventDefault();
			event.stopPropagation();
			var windowHeight = parseInt($(window).height()) - 39,
			$next = $(event.currentTarget).nextAll('.submenu:first');
			$next.show(0, function(){
				$(event.currentTarget).closest('ul').addClass('translated');
			});
			this.setupSubMenuHeight($next);
			if(this.$el.hasClass("is-mobile")){
				$next.css({maxHeight: windowHeight+"px"});
			}
		},
		closeSubmenu: function(event){
			event.preventDefault();
			event.stopPropagation();
			$(event.currentTarget).closest('ul.translated').removeClass('translated');
			setTimeout(function(){
				$(event.currentTarget).closest('.submenu').hide();
			},300);
		},
		getOS: function(){
			var ua = navigator.userAgent;
			var uaindex;

			var mobile = {OS: "", OSver: "", Device: ""};

			// determine OS
			if ( ua.match(/iPad/i) || ua.match(/iPhone/i) ){
				mobile.OS = 'iOS';
				uaindex  = ua.indexOf( 'OS ' );
			} else if ( ua.match(/Android/i) ){
				mobile.OS = 'Android';
				uaindex  = ua.indexOf( 'Android ' );
			} else {
				mobile.OS = 'unknown';
			}

			if(ua.match(/iPad/i)){
				mobile.Device = 'iPad';
			}else if(ua.match(/iPhone/i)){
				mobile.Device = 'iPhone';
			}else{
				mobile.Device = 'unknown';
			}

			// determine version
			if ( mobile.OS === 'iOS'  &&  uaindex > -1 ){
				mobile.OSver = ua.substr( uaindex + 3, 1 ).replace( '_', '.' );
			} else if ( mobile.OS === 'Android'  &&  uaindex > -1 ) {
				mobile.OSver = ua.substr( uaindex + 8, 3 );
			} else {
				mobile.OSver = 'unknown';
			}
			return mobile;
		}
	});
});