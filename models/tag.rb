class Tag < Sequel::Model
	unrestrict_primary_key
	
	many_to_many :contents

end
