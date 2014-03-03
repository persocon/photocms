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
	
end