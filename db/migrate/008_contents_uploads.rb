Sequel.migration do
  up do
    create_table :contents_uploads do

      foreign_key :content_id, :contents
      foreign_key :upload_id, :uploads

    end
  end

  down do
    drop_table :contents_uploads
  end
end
