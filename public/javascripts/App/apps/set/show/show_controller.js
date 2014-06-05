App.module("SetApp.Show", function(Show, App, Backbone, Marionette, $, _){
	Show.Controller = {
		showSet: function(slug){
			var fetchingSet = App.request("set:entity", slug);
			$.when(fetchingSet).done(function(set){
				var setView;
				if(set !== undefined){
					setView = new Show.Set({
						model: set
					});
				}else{
					console.log("NonExist")
					// contactView = new Show.MissingContact();
				}

				App.mainRegion.show(setView);
			});
		}
	}
});