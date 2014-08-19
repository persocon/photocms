class TreeHelper
	
	def self.do_something(category, content_categories)
		 unless category.blank? 
	         html = "<ul>"
	         	category.each do |cat|
	         		checked = content_categories.include? cat
	         		check = checked ? 'checked="checked"' : ''
	         		html << "<li>"
	         			html << "<input type='checkbox' name='categories[]' value='#{cat.id}' #{check} />"
	         			html << "#{cat.title}"
	         			unless cat.children.blank?
	         				html << do_something(cat.children, content_categories)
	         			end
	         		html << "</li>"
	         	end
	         html << "</ul>"
	         html.html_safe
         end 
	end
	
	def self.do_other_thing(item)
		unless item.blank?
			html = "<ol class='dd-list'>"
				item.each do |i|
					html << "<li class='dd-item' data-id='#{i["id"]}' data-type='#{i["type"]}' data-title='#{recovery_title(i["title"], i["id"], i["type"])}' data-url='#{i["url"]}' data-slug='#{i["slug"]}'>"
						html << "<div class='dd-handle'>#{recovery_title(i["title"], i["id"], i["type"])}</div>"
						html << "<div class='dd-remove'><span class='icon icon-remove'></span></div>"
							unless i["children"].blank?
								html << do_other_thing(i["children"])
							end
					html << "</li>"
				end
			html << "</ol>"
			html.html_safe
		end
	end

	def self.recovery_title(title, id, type)
		unless id.blank?
			if id == 0
				return title
			else
				unless type.blank?
					if type === "set" || type === "page"
						content = Content[id]
						return content.title
					end

					if type === "category"
						category = Category[id]
						return category.title
					end

					if type === "tag"
						tag = Tag[id]
						return tag.title
					end
				else
					return title
				end
			end
		else
			return title
		end
	end
end