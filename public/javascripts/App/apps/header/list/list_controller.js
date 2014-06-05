App.module("HeaderApp.List", function(List, App, Backbone, Marionette, $, _){
	List.Controller = {
		listHeader: function(){
			links = App.request("header:entity", "main");
			$.when(links).done(function(links){
					var header = new List.Header({model: links});
					App.headerRegion.show(header);
			});
		}
	}
});
