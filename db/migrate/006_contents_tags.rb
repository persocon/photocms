Sequel.migration do
  up do
    create_table :contents_tags do
      
      foreign_key :content_id, :contents
      foreign_key :tag_id, :tags
      
      # primary_key [:content_id, :tag_id]
    end
  end

  down do
    drop_table :contents_tags
  end
end
