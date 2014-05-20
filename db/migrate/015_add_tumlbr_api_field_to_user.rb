Sequel.migration do
  up do
  	alter_table :accounts do
      add_column :tumblr_url, String, :default => ''
      add_column :tumblr_oauth_consumer_key, String, :default => ''
      add_column :tumblr_oauth_secret_key, String, :default => ''
    end
  end

  down do
  	drop_table :accounts
  end
end
