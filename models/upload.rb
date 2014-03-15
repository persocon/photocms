class Upload < Sequel::Model

   mount_uploader :file, Uploader

   many_to_many :contents

   def before_create
      self.created_at = Time.now
   end
   
   def before_destroy
      remove_associations
   end
   
   def remove_associations
      self.remove_all_contents
   end
end
