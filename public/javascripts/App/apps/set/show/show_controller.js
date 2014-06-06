App.module("SetApp.Show", function(Show, App, Backbone, Marionette, $, _){
	Show.Controller = {
		showSet: function(slug){
			var loadingView = new App.Common.Views.Loading();
			App.mainRegion.show(loadingView);
			
			var fetchingSet = App.request("set:entity", slug);
			$.when(fetchingSet).done(function(set){
				var setView;
				if(set !== undefined){
					setView = new Show.Set({
						model: set
					});
				}else{
					setView = new App.Common.Views.MissingPage();
				}

				App.mainRegion.show(setView);
			});
		}
	}
});