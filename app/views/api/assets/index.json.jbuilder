 json.files @assets do |asset|
  json.id asset.id
  json.path asset.path
  json.url asset.s3_url
  json.file_name asset.file_name
  json.file_content_type asset.file_content_type
  json.file_size asset.file_size
  json.file_updated_at asset.file_updated_at
  json.file_id asset.file_id
  json.prev_file_id asset.prev_file_id
  json.is_large asset.is_large
  json.is_modified asset.is_modified
  json.file_fingerprint asset.file_fingerprint
  json.updated_at asset.updated_at
end