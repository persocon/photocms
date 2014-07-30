class ContentHelper

	def self.get_all_json
		contents = Content.where(:type => 'post', :published => true).order(:sort, Sequel.desc(:created_at)).all
		json = GeneralHelper::map_content(contents)
		json.to_json
	end

	def self.get_random_featured
		contents = Content.where(:type => 'post', :published => true, :featured => 1).all
		json = GeneralHelper::map_content(contents, true)
		json.to_json
	end

	def self.get_set(slug)
		contents = Content.where(:type => 'post', :published => true, :slug => slug)
		json = GeneralHelper::map_single_content(contents)
		json.to_json
	end

	def self.get_from_category(category_id)
		contents = Content.eager_graph(:categories).where(:type => 'post', :published => true, :category_id => category_id).order(:sort, Sequel.desc(:created_at)).all
		json = GeneralHelper::map_content(contents)
		json.to_json
	end

	def self.get_from_tag(tag_id)
		contents = Content.eager_graph(:tags).where(:type => 'post', :published => true, :tag_id => tag_id).order(:sort, Sequel.desc(:created_at)).all
		json = GeneralHelper::map_content(contents)
		json.to_json
	end

end