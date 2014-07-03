App.module("SetApp.Show", function(Show, App, Backbone, Marionette, $, _){
	Show.Controller = {
		showSet: function(slug){
			var loadingView = new App.Common.Views.Loading();
			App.mainRegion.show(loadingView);
			
			var fetchingSet = App.request("set:entity", slug);

			var setListLayout = new App.Common.Views.Layout();
			var setListPanel = new App.Common.Views.Panel();
			var footerView = new App.Common.Views.Footer();

			$.when(fetchingSet).done(function(set){
				var setView;
				if(set !== undefined){
					setView = new Show.Set({
						model: set
					});
				}else{
					setView = new App.Common.Views.MissingPage();
				}

				setListLayout.on("show", function(){
					setListLayout.panelRegion.show(setListPanel);
					setListLayout.contentRegion.show(setView);
					setListLayout.footerRegion.show(footerView);
				});

				App.mainRegion.show(setListLayout);
			});
		}
	}
});