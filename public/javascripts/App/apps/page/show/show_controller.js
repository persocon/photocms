App.module("PageApp.Show", function(Show, App, Backbone, Marionette, $, _){
	Show.Controller = {
		showPage: function(slug){
			var loadingView = new App.Common.Views.Loading();
			App.mainRegion.show(loadingView);
			
			var fetchingPage = App.request("page:entity", slug);

			var pageListLayout = new App.Common.Views.Layout();
			var pageListPanel = new App.Common.Views.Panel();
			var footerView = new App.Common.Views.Footer();

			$.when(fetchingPage).done(function(page){
				var pageView;
				if(page !== undefined){
					pageView = new Show.Page({
						model: page
					});
				}else{
					pageView = new App.Common.Views.MissingPage();
				}

				pageListLayout.on("show", function(){
					pageListLayout.panelRegion.show(pageListPanel);
					pageListLayout.contentRegion.show(pageView);
					pageListLayout.footerRegion.show(footerView);
				});

				App.mainRegion.show(pageListLayout);
			});
		}
	}
});