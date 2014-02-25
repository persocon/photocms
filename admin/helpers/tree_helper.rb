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
end