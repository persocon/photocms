class PageHelper

	def self.get_all_json
		contents = Content.where(:type => 'page', :published => true).order(:sort).all
		json = GeneralHelper::map_page(contents)
		json.to_json
	end

	def self.get_page(slug)
		contents = Content.where(:type => 'page', :published => true, :slug => slug)
		json = GeneralHelper::map_page(contents)
		json.to_json
	end

end