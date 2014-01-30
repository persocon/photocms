class Category < Sequel::Model

	many_to_many :contents

end
