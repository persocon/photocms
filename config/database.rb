Sequel::Model.plugin(:schema)
Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
Sequel::Model.db = case Padrino.env
  when :development then Sequel.connect("mysql2://root:@localhost/photo_cms_development", :loggers => [logger])
  when :production  then Sequel.connect("mysql2://persocon:accela503@localhost/photo_cms_production", :loggers => [logger])
  when :test        then Sequel.connect("mysql2://localhost/photo_cms_test",        :loggers => [logger])
end
