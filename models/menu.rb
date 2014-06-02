class Menu < Sequel::Model

	def before_create
		sluger = Sluger.new
		sluger.slugfy(self)
	end

	def after_save
		clear_cache
	end

	def clear_cache
		PhotoCms::App.cache.delete("/api/v1/menus")
		PhotoCms::App.cache.delete("/api/v1/menu/#{self.slug}")
	end

end
