Sequel.migration do
  up do
    create_table :menus do
      primary_key :id
      String :slug
      String :data, :text => true
    end
  end

  down do
    drop_table :menus
  end
end
