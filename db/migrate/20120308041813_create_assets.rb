class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.integer :user_id
      t.integer :folder_id
      t.string  :uploaded_file_file_name
      t.string  :uploaded_file_content_type
      t.integer :uploaded_file_file_size
      t.hstore  :uploaded_file_meta
      t.datetime :uploaded_file_updated_at
      t.timestamps
    end

    add_index :assets, :user_id
    add_index :assets, :folder_id
  end

  def self.down
    drop_table :assets
  end
end
