class Menu < Sequel::Model

	def before_create
		sluger = Sluger.new
		sluger.slugfy(self)
	end

end
