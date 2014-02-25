Sequel.migration do
  up do
    alter_table :categories do
      add_foreign_key :parent_id, :categories
    end
  end

  down do
    drop_table :categories
  end
end
