App.module("Entities", function(Entities, App, Backbone, Marionette, $, _){
	Entities.Header = Backbone.Model.extend({
		initialize: function(options){
			this.slug = options.slug
		},
		defaults: {
			title: "",
			slug: "",
			data: {}
		},
		urlRoot: function(){
			return "/api/v1/menu/" + this.slug;
		},
		parse: function(data){
			return data[0];
		}
		
	});

	Entities.HeaderCollection = Backbone.Collection.extend({
		url: "/api/v1/menus",
		model: Entities.Header
	});

	var API = {
		getHeadersEntities: function(){
			var headers = new Entities.HeaderCollection();
			var defer = $.Deferred();
			headers.fetch({
				success: function(data){
					defer.resolve(data);
				}
			});
			
			return defer.promise();
		},
		getHeaderEntity: function(slug){
			var header = new Entities.Header({
				slug: slug
			});
			var defer = $.Deferred();
			header.fetch({
				success: function(data){
					defer.resolve(data);
				},
				error: function(data){
					defer.resolve(undefined);
				}
			});
			return defer.promise();
		}
	}

	App.reqres.setHandler("header:entities", function(){
		return API.getHeadersEntities();
	});
	
	App.reqres.setHandler("header:entity", function(slug){
		return API.getHeaderEntity(slug);
	})
});