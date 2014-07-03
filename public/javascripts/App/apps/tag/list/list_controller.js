App.module("TagApp.List", function(List, App, Backbone, Marionette, $, _){
	List.Controller = {
		listTag: function(slug){
			var loadingView = new App.Common.Views.Loading();
			App.mainRegion.show(loadingView);

			var fetchingSets = App.request("tag:entity", slug);

			var tagListLayout = new App.Common.Views.Layout();
			var tagListPanel = new App.Common.Views.Panel();
			var footerView = new App.Common.Views.Footer();

			$.when(fetchingSets).done(function(sets){
				
				var setsListView = new App.SetApp.List.Sets({
					collection: sets
				});

				setsListView.on("itemview:set:show", function(childView, args){
					App.trigger("set:show", args.model.get("slug"));
				});

				tagListLayout.on("show", function(){
					tagListLayout.panelRegion.show(tagListPanel);
					tagListLayout.contentRegion.show(setsListView);
					tagListLayout.footerRegion.show(footerView);
				});

				App.mainRegion.show(tagListLayout);

			});
		}
	}
});