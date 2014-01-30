class Upload < Sequel::Model

   mount_uploader :file, Uploader
end
