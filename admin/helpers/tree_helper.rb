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
					html << "<li class='dd-item' data-id='#{i["id"]}' data-type='#{i["type"]}' data-title='#{i["title"]}'>"
						html << "<div class='dd-handle'>#{i["title"]}</div>"
							unless i["children"].blank?
								html << do_other_thing(i["children"])
							end
					html << "</li>"
				end
			html << "</ol>"
			html.html_safe
		end
	end
end