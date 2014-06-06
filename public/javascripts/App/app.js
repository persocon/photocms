var App = new Marionette.Application();

function markdown(context, options) {
	var showdown = new Showdown.converter();
	return new Handlebars.SafeString(showdown.makeHtml(context));
}

Handlebars.registerHelper('markdown', markdown);

Handlebars.registerHelper('list', function(items, options) {
  var out = "";
	_.each(items, function(item){
		var classe = "";
		if(item.children){
			classe = "class='has-submenu'"
		}
		out += "<li "+classe+">";
		if(item.type === "external_link"){
			out += "<a href='" + item.url + "' title='" + item.title + "' class='external_link' target='_blank'>";
				out += item.title;
			out += "</a>";
		}else{		
			out += "<a href='#" + item.type + "/" + item.slug + "' title='" + item.title + "' class='internal_link' data-type='"+item.type+"' data-slug='"+item.slug+"'>";
				out += item.title;
			out += "</a>"
		}
		if(item.children){
			out += "<ul class='submenu'>";
				out += Handlebars.helpers.list(item.children);
			out += "</ul> ";
		}
		out += "</li>";
	})

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