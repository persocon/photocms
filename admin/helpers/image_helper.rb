class ImageHelper
	
	def self.base64ToImage(hash)
		base64 = hash[:upload][:file][:base64]
		base64 = base64.split(',')
		base64 = Base64.decode64(base64[1])
		
		tempfile = Tempfile.new("RackMultipart")
		tempfile.binmode
		tempfile.write(base64)
		tempfile.rewind
		
		uploaded_file = Uploader.new(
																:tempfile => tempfile, 
																:content_type => hash[:upload][:file][:type], 
																:filename => hash[:upload][:file][:filename], 
																:original_filename => hash[:upload][:file][:filename],
																:created_at => Time.now
																)
		uploaded_file.model
	end
	
	def self.get_all_images(content_id = nil)
    	@uploads = Upload.all
        hash = Array.new
        @uploads.each do |upload|
          onThePost = ""
          unless content_id.nil?
	          if upload.contents
	            x = upload.contents_dataset.where({:id => content_id}).first
	            if x
	              onThePost = true
	            end
	          end
	      end
          hash << {
            :id => upload.id,
            :filename => upload.file.url.split("/").last,
            :file => upload.file,
            :thumb => upload.file.thumb,
            :onThePost => onThePost
          }
        end
        hash.to_json
	end

	def self.get_all_images_on_this_post(content_id)
		content = Content[content_id]
	    @uploads = content.uploads.sort_by{|key| key[:sort]}
	    hash = Array.new
	    @uploads.each do |upload|
	      hash << {
	        :id => upload.id,
	        :filename => upload.file.url.split("/").last,
	        :file => upload.file,
	        :thumb => upload.file.thumb
	      }
	    end
	    hash.to_json
	end
end