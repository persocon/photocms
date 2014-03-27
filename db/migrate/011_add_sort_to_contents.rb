Sequel.migration do
  up do
    alter_table :contents do
      add_column :sort, Integer
    end
  end

  down do
    drop_table :contents
  end
end
