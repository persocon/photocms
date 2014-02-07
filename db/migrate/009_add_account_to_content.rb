Sequel.migration do
  up do
    alter_table :contents do
      add_foreign_key :account_id, :accounts
    end
  end

  down do
    drop_table :contents
  end
end
