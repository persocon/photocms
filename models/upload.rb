class Upload < Sequel::Model

   mount_uploader :file, Uploader

   many_to_many :contents

   def before_create
      self.created_at = Time.now
   end
end
