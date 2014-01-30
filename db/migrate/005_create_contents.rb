Sequel.migration do
  up do
    create_table :contents do
      primary_key :id
      String :title
      String :slug
      Text :body
      Boolean :published
      String :type
      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table :contents
  end
end
