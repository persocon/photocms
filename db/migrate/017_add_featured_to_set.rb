Sequel.migration do
  up do
    alter_table :contents do
      add_column :featured, TrueClass, :default => false
      add_column :featured_image_id, Integer, :default => nil
    end
  end
  
  down do
    drop_table :contents
  end
end
