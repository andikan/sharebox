class AddUploadedFileFingerprintColumnToAsset < ActiveRecord::Migration
   def self.up
    add_column :assets, :random_hex, :string
    add_column :assets, :original_file_name, :string
    add_column :assets, :uploaded_file_fingerprint, :string
  end

  def self.down
    remove_column :assets, :random_hex
    remove_column :assets, :original_file_name
    remove_column :assets, :uploaded_file_fingerprint
  end
end
