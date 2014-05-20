Sequel.migration do
  up do
  	alter_table :accounts do
      add_column :tumblr_token, String, :default => ''
      add_column :tumblr_token_secret, String, :default => ''
    end
  end

  down do
  	drop_table :accounts
  end
end
