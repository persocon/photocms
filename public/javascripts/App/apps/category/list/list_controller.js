App.module("CategoryApp.List", function(List, App, Backbone, Marionette, $, _){
	List.Controller = {
		listCategory: function(slug){
			var loadingView = new App.Common.Views.Loading();
			App.mainRegion.show(loadingView);

			var fetchingSets = App.request("category:entity", slug);

			var categoryListLayout = new App.Common.Views.Layout();
			var categoryListPanel = new App.Common.Views.Panel();

			$.when(fetchingSets).done(function(sets){
				
				var setsListView = new App.SetApp.List.Sets({
					collection: sets
				});

				setsListView.on("itemview:set:show", function(childView, args){
					App.trigger("set:show", args.model.get("slug"));
				});

				categoryListLayout.on("show", function(){
					categoryListLayout.panelRegion.show(categoryListPanel);
					categoryListLayout.contentRegion.show(setsListView);
				});

				App.mainRegion.show(categoryListLayout);

			});
		}
	}
});