class Content < Sequel::Model
	unrestrict_primary_key
	
	many_to_one :accounts
	many_to_many :tags
	many_to_many :uploads
	many_to_many :categories
end