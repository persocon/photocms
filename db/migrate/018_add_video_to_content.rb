Sequel.migration do
  up do
    alter_table :contents do
      add_column :video_url, String, :default => ''
    end
  end

  down do
    drop_table :contents
  end
end
