var App = new Marionette.Application();

Handlebars.registerHelper('list', function(items, options) {
  var out = "";
	_.each(items, function(item){
		out = out + "<li>";
		out = out + item.title;
		if(item.children){
			out = out + "<ul class='submenu'>";
			out = out + Handlebars.helpers.list(item.children);
			out = out + "</ul> ";
		}
		out = out + "</li>";
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

		if(this.getCurrentRoute() === ""){
			
		}
	}
});