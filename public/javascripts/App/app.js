var App = new Marionette.Application();

function markdown(context, options) {
	var showdown = new Showdown.converter();
	return new Handlebars.SafeString(showdown.makeHtml(context));
}

Handlebars.registerHelper('markdown', markdown);

Handlebars.registerHelper('list', function(items, options) {
  var out = "";
  	if(!options.nohome){
  		out += "<ul class='menu-mobile'>";
  		out += "<li><a href='#' class='home internal_link'>Home</a></li>";
  	}
	_.each(items, function(item){
		var classe = "",
			icon = "";
		if(item.children){
			classe = "class='has-submenu'";
			icon = " <i class='icon icon-chevron-right is-float-right open-submenu'></i>";
		}
		out += "<li "+classe+">";
		if(item.type === "external_link"){
			out += "<a href='" + item.url + "' title='" + item.title + "' class='external_link' target='_blank'>";
				out += item.title;
		}else{		
			out += "<a href='#" + item.type + "/" + item.slug + "' title='" + item.title + "' class='internal_link' data-type='"+item.type+"' data-slug='"+item.slug+"'>";
				out += item.title;
		}
		out += "</a>";
		out += icon;
		if(item.children){
			out += "<ul class='submenu'>";
				out += "<li class='close-list-item'><i class='icon icon-chevron-left is-float-left close-submenu'></i><a href='#' class='close-submenu reset-padding'>Back</a></li>";
				out += Handlebars.helpers.list(item.children, {nohome: true});
			out += "</ul> ";
		}
		out += "</li>";
	});
	if(!options.nohome){
		out += "</ul>";
	}

	return new Handlebars.SafeString(out);
});

App.addRegions({
	headerRegion: "#header-region",
	mainRegion: "#main-region"
});

App.navigate = function(route, options){
	options || (options = {});
	Backbone.history.navigate(route, options);
};

App.getCurrentRoute = function(){
	return Backbone.history.fragment;
}

App.on("initialize:after", function(){
	if(Backbone.history){
		Backbone.history.start();
	}
});

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