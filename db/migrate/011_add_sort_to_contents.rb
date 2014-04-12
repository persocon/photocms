Sequel.migration do
  up do
    alter_table :contents do
      add_column :sort, Integer, :default => 0
    end
  end

  down do
    drop_table :contents
  end
end
