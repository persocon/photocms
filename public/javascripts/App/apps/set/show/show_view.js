App.module("SetApp.Show", function(Show, App, Backbone, Marionette, $, _){
	Show.Set = Marionette.ItemView.extend({
		template: Handlebars.compile($("#set-view").html()),
		className: "set",
		initialize: function(){
			if( _.isEmpty(this.model.get('featured_image')) ){
				this.$el.addClass("not-featured");
			}
		},
		onRender: function(){
			if( !_.isEmpty(this.model.get('video')) && !_.isEmpty(this.model.get('video_iframe'))){
				this.setupVideoMaxHeight();
				$(window).on('resize', $.proxy(this.setupVideoMaxHeight, this));
			}
		},
		onBeforeDestroy: function(){
			if( !_.isEmpty(this.model.get('video')) && !_.isEmpty(this.model.get('video_iframe'))){
				$(window).off('resize');
			}
		},
		setupVideoMaxHeight: function(){
			var element = this.$el.find('iframe');
			var video = {width: parseInt(element.attr('width')), height: parseInt(element.attr('height'))};
			
			element.attr('aspectRatio', video.width / video.height);
			
			var newWidth = $(window).width();
			
			element.removeAttr('width').removeAttr('height');
			
			var aspectRatio = element.attr('aspectRatio');
			
			element.width(newWidth).height(video.height / aspectRatio);
			
		}
	});
});