var App = new Marionette.Application();

function css(context, options){
	var html = '<style>';
			html += '#'+context.slug+' figure {';
				if(context.featured_image){
					html += 'background-image: url('+context.featured_image.files.default+')';
				}else{
					html += 'background-image: url('+context.images[0].files.default+')';
				}
			html += '}';
			html += '@media (min-width: 320px){';
				html += '#'+context.slug+' figure {';
					if(context.featured_image){
						html += 'background-image: url('+context.featured_image.files.mobile+')';
					}else{
						html += 'background-image: url('+context.images[0].files.mobile+')';
					}
				html += '}';
			html += '}'
			html += '@media (min-width: 768px){';
				html += '#'+context.slug+' figure {';
					if(context.featured_image){
						html += 'background-image: url('+context.featured_image.files.tablet+')';
					}else{
						html += 'background-image: url('+context.images[0].files.tablet+')';
					}
				html += '}';
			html += '}'
			html += '@media (min-width: 1025px){';
				html += '#'+context.slug+' figure {';
					if(context.featured_image){
						html += 'background-image: url('+context.featured_image.files.desktop+')';
					}else{
						html += 'background-image: url('+context.images[0].files.desktop+')';
					}
				html += '}';
			html += '}'
			html += '@media (min-width: 1281px){';
				html += '#'+context.slug+' figure {';
					if(context.featured_image){
						html += 'background-image: url('+context.featured_image.files.desktop_big+')';
					}else{
						html += 'background-image: url('+context.images[0].files.desktop_big+')';
					}
				html += '}';
			html += '}'
		html += '</style>';

	return new Handlebars.SafeString(html);
}
Handlebars.registerHelper('css', css);

function markdown(context, options) {
	var showdown = new Showdown.converter();
	return new Handlebars.SafeString(showdown.makeHtml(context));
}

Handlebars.registerHelper('markdown', markdown);

Handlebars.registerHelper('safe_html', function(text) {
	// text = Handlebars.Utils.escapeExpression(text);

	return new Handlebars.SafeString(text);
});

Handlebars.registerPartial('menu-item', $('#partial-menu-item-view').html());

App.addRegions({
	headerRegion: "#header-region",
	mainRegion: "#main-region"
});

App.navigate = function(route, options){
	options || (options = {});
	Backbone.history.navigate(route, options);
	App.trigger("route:change")
};

App.getCurrentRoute = function(){
	return Backbone.history.fragment;
}

Marionette.AppRouter.prototype.onRoute = function(){
	App.trigger("route:change")
}

App.on("route:change", function(){
	var url = Backbone.history.getFragment();
	if (!/^\//.test(url) && url !== ""){
			url = "/#" + url;
	}
	_gaq.push(['_trackPageview', url]);
});

App.on("initialize:after", function(){
	if(Backbone.history){
		Backbone.history.start();
		GoSquared.q = GoSquared.q || [];
		GoSquared.q.push(['TrackView']);
	}
});
// var supportsOrientationChange = "onorientationchange" in window,
//     orientationEvent = supportsOrientationChange ? "orientationchange" : "resize";
// window.addEventListener(orientationEvent, function() {
//   App.SetApp.List.Sets.trigger('itemview:setup');
// }, false);

// App.on("setup:sizes", function(){
// 	var width = $(window).width(),
// 		height = $(window).height();
// 	$('body, #main-region').width(width).height(height);
// 	$('#contents-region').height(height - 40);
// });

// window.addEventListener('orientationchange', function(){
// 	setTimeout(function(){
// 		// App.trigger("setup:sizes");
// 	},300);
// }, false);