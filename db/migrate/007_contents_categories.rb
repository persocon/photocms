Sequel.migration do
  up do
    create_table :contents_categories do

      foreign_key :content_id, :contents
      foreign_key :category_id, :categories

    end
  end

  down do
    drop_table :contents_categories
  end
end
