App.module("Entities", function(Entities, App, Backbone, Marionette, $, _){
	Entities.Page = Backbone.Model.extend({
		initialize: function(options){
			this.slug = options.slug
		},
		urlRoot: function(){
			return "/api/v1/page/" + this.slug;
		},
		parse: function(data){
			var response = "";
			if(data){
				response = data[0];
			}else{
				this.clear();
				response = {};
			}
			return response;
		}
	});

	var API = {
		getPageEntity: function(slug){
			var page = new Entities.Page({
				slug: slug
			});
			var defer = $.Deferred();
			page.fetch({
				success: function(data){
					if(data.get("title")){
						defer.resolve(data);
					}else{
						defer.resolve(undefined);
					}
				},
				error: function(data){
					defer.resolve(undefined);
				}
			});
			return defer.promise();
		}
	}

	App.reqres.setHandler("page:entity", function(slug){
		return API.getPageEntity(slug);
	})
});