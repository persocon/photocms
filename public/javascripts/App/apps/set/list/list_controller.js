App.module("SetApp.List", function(List, App, Backbone, Marionette, $, _){
	List.Controller = {
		listSets: function(){
			var loadingView = new App.Common.Views.Loading();
			App.mainRegion.show(loadingView);

			var fetchingSets = App.request("set:entities");

			var setListLayout = new App.Common.Views.Layout();
			var setListPanel = new App.Common.Views.Panel();

			$.when(fetchingSets).done(function(sets){
				
				var setsListView = new List.Sets({
					collection: sets
				});

				setListLayout.on("show", function(){
					setListLayout.panelRegion.show(setListPanel);
					setListLayout.contentRegion.show(setsListView);
				});

				setsListView.on('show', function(){

				});

				setsListView.on("itemview:set:show", function(childView, args){
					App.trigger("set:show", args.model.get("slug"));
				});

				App.mainRegion.show(setListLayout);

			});
		}
	}
});