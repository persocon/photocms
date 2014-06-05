App.module("SetApp.List", function(List, App, Backbone, Marionette, $, _){
	List.Controller = {
		listSets: function(criterion){

			var fetchingSets = App.request("set:entities");

			$.when(fetchingSets).done(function(sets){
				
				var setsListView = new List.Sets({
					collection: sets
				});

				setsListView.on("itemview:set:show", function(childView, args){
					App.trigger("set:show", args.model.get("slug"));
				});

				App.mainRegion.show(setsListView);

			});
		}
	}
});