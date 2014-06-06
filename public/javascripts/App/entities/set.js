App.module("Entities", function(Entities, App, Backbone, Marionette, $, _){
	Entities.Set = Backbone.Model.extend({
		initialize: function(options){
			this.slug = options.slug
		},
		urlRoot: function(){
			return "/api/v1/set/" + this.slug;
		}
	});
	
	Entities.SetParsed = Entities.Set.extend({
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

	Entities.SetCollection = Backbone.Collection.extend({
		url: "/api/v1/sets",
		model: Entities.Set
	});

	var API = {
		getSetsEntities: function(){
			var sets = new Entities.SetCollection();
			var defer = $.Deferred();
			sets.fetch({
				success: function(data){
					defer.resolve(data);
				}
			});

			return defer.promise();
		},
		getSetEntity: function(slug){
			var set = new Entities.SetParsed({
				slug: slug
			});
			var defer = $.Deferred();
			set.fetch({
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

	App.reqres.setHandler("set:entities", function(){
		return API.getSetsEntities();
	});

	App.reqres.setHandler("set:entity", function(slug){
		return API.getSetEntity(slug);
	})
});