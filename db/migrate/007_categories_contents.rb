Sequel.migration do
  up do
    create_table :categories_contents do

      foreign_key :content_id, :contents
      foreign_key :category_id, :categories

    end
  end

  down do
    drop_table :categories_contents
  end
end
