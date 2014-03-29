Sequel.migration do
  up do
    alter_table :menus do
      add_column :title, String
    end
  end

  down do
    drop_table :menus
  end
end
