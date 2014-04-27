class Asset < ActiveRecord::Base
  # attr_accessible :user_id, :uploaded_file, :folder_id

  belongs_to :user
  belongs_to :folder

  # set up "uploaded_file" field as attached_file (using Paperclip)
  has_attached_file :uploaded_file,
          :path => ":class/:hash.:extension",
          :hash_secret => "magicbox_hash_secret",
          :storage => :s3,
          :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
          :bucket => "magicbox-production"

  validates_attachment_size :uploaded_file, :less_than => 150.megabytes
  validates_attachment_presence :uploaded_file
  do_not_validate_attachment_file_type :uploaded_file
  
  def file_name
    uploaded_file_file_name
  end

  def file_size
    uploaded_file_file_size
  end

  def file_content_type
    uploaded_file_content_type
  end

  def file_updated_at
    uploaded_file_updated_at
  end

  def file_fingerprint
    uploaded_file_fingerprint
  end

  def s3_url
    uploaded_file.expiring_url.split("?")[0]
  end
end
