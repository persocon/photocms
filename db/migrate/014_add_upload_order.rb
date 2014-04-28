Sequel.migration do
  up do
  	alter_table :uploads do
      add_column :sort, Integer, :default => 0
    end
  end

  down do
  	drop_table :uploads
  end
end
