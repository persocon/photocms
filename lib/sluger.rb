class Sluger

	def slugfy(instance)
		#if slug was typed do slugfy
		unless instance.slug.nil? || instance.slug.blank?
			instance.slug = find_slugs instance, instance.slug
			#if there's no slug typed try to get the title
		else instance.title.present?
			instance.slug = find_slugs instance, instance.title
		end
	end
	
	private

	def find_slugs(instance, to_slug)
		num_of_slugs = instance.class.select(:slug).where(Sequel.like(:slug, "#{to_slug.to_url}%")).all.count.to_int
		#check if num_of_slugs returned something
		if num_of_slugs > 0
			return "#{to_slug.to_url}-#{num_of_slugs}"
		else
			return to_slug.to_url
		end
	end
end