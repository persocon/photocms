Sequel.migration do
  up do
    create_table :contents_tags do
      String :content_id
      String :tag_id
      primary_key [:content_id, :tag_id]
    end
  end

  down do
    drop_table :contents_tags
  end
end
