App.module("PageApp.Show", function(Show, App, Backbone, Marionette, $, _){
	Show.Controller = {
		showPage: function(slug){
			var loadingView = new App.Common.Views.Loading();
			App.mainRegion.show(loadingView);
			
			var fetchingPage = App.request("page:entity", slug);
			$.when(fetchingPage).done(function(page){
				var pageView;
				if(page !== undefined){
					pageView = new Show.Page({
						model: page
					});
				}else{
					pageView = new App.Common.Views.MissingPage();
				}

				App.mainRegion.show(pageView);
			});
		}
	}
});