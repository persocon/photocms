App.module("Entities", function(Entities, App, Backbone, Marionette, $, _){
	Entities.Tag = Backbone.Model.extend({
		initialize: function(options){
			this.slug = options.slug
		},
		urlRoot: function(){
			return "/api/v1/tag/" + this.slug;
		}
	});

	Entities.TagCollection = Backbone.Collection.extend({
		initialize: function(options){
			this.slug = options.slug
		},
		url: function(){
			return "/api/v1/tag/"+this.slug;
		},
		model: Entities.Tag
	});

	var API = {
		getTagEntity: function(slug){
			var sets = new Entities.TagCollection({
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

	App.reqres.setHandler("tag:entity", function(slug){
		return API.getTagEntity(slug);
	})
});