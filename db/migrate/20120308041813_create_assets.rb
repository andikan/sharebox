class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.integer :user_id
      t.integer :folder_id
      t.string  :file_id
      t.string  :prev_file_id
      t.string  :checksum
      t.string  :url
      t.string  :path
      t.string  :uploaded_file_file_name
      t.string  :uploaded_file_content_type
      t.integer :uploaded_file_file_size
      t.datetime :uploaded_file_updated_at
      t.datetime :deleted_at
      t.hstore  :data, default: '', null: false
      t.hstore  :uploaded_file_meta, default: '', null: false
      t.hstore  :chunks, array: true, default: '{}', null: false
      t.boolean :is_large, default: false
      t.boolean :is_modified
      t.timestamps
    end

    add_index :assets, :user_id
    add_index :assets, :folder_id
  end

  def self.down
    drop_table :assets
  end
end
