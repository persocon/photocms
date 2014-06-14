App.module("HeaderApp.List", function(List, App, Backbone, Marionette, $, _){
	List.Controller = {
		listHeader: function(){
			links = App.request("header:entity", "main");
			$.when(links).done(function(links){
					var header = new List.Header({model: links});

					header.on("header:navigate", function(args){
						if(args.type === "set"){
							App.trigger("set:show", args.slug);
						}else if(args.type === "page"){
							App.trigger("page:show", args.slug);
						}else if(args.type === "category"){
							App.trigger("category:list", args.slug);
						}else if(args.type === "tag"){
							App.trigger("tag:list", args.slug);
						}else{
							App.trigger("set:list")
						}
					});
					App.on("header:showMenu", function(){
						header.openMenu();
					})

					App.headerRegion.show(header);
			});
		}
	}
});
