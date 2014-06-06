App.module("Entities", function(Entities, App, Backbone, Marionette, $, _){
	Entities.Category = Backbone.Model.extend({
		initialize: function(options){
			this.slug = options.slug
		},
		urlRoot: function(){
			return "/api/v1/category/" + this.slug;
		}
	});

	Entities.CategoryCollection = Backbone.Collection.extend({
		initialize: function(options){
			this.slug = options.slug
		},
		url: function(){
			return "/api/v1/category/"+this.slug;
		},
		model: Entities.Category
	});

	var API = {
		getCategoryEntity: function(slug){
			var sets = new Entities.CategoryCollection({
				slug: slug
			});
			var defer = $.Deferred();
			sets.fetch({
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

	App.reqres.setHandler("category:entity", function(slug){
		return API.getCategoryEntity(slug);
	})
});