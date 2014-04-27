class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => "", :comment => 'Email'
      t.string :encrypted_password, :null => true,  :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Token authenticatable
      t.string   :authentication_token

      t.string   :name
      t.string   :username
      t.string   :displayname
      t.string   :uid
      t.string   :provider
      t.string   :gender
      t.string   :fb_token
      t.hstore   :data, default: '', null: false
      t.hstore   :mac_addresses, array: true, default: '{}', null: false

      ## Access log
      t.datetime :current_access_at
      t.datetime :last_access_at
      t.datetime :latest_updated_at

      # Uncomment below if timestamps were not included in your original model.
      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :uid,                  :unique => true
    add_index :users, :fb_token,             :unique => true
  end

  def self.down
    drop_table :users
  end
end
