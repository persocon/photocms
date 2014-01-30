class Upload < Sequel::Model

   mount_uploader :file, Uploader

   many_to_many :contents

end
