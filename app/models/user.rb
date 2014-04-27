class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  validates :email, :presence => true, :uniqueness => true

  has_many :assets
  has_many :folders

  # this is for folders which the user has shared
  has_many :shared_folders, :dependent => :destroy
  
  # this is for folders which the user has been shared by others
  has_many :being_shared_folders, :class_name => "SharedFolder", :foreign_key => "shared_user_id", :dependent => :destroy

  has_many :shared_folders_by_others, :through => :being_shared_folders, :source => :folder

  after_create :check_and_assign_shared_ids_to_shared_folders
  
  # this is to make sure the id of the new user of which the email addresses already used to share folders by others, have access to those folders
  def check_and_assign_shared_ids_to_shared_folders
    # first check if the new user's email exists in any of the shared folder records

    shared_folders_with_same_email = SharedFolder.where(shared_email: self.email)
    
    if shared_folders_with_same_email
      # loop and update the shared user id with this new user id
      shared_folders_with_same_email.each do |shared_folder|
        shared_folder.shared_user_id = self.id
        shared_folder.save
      end
    end
  end

  # to check if a user has access to this specific folder
  def has_share_access?(folder)
    # doesn't have share access if folder is nil (i.e., file is top-level)
    return false if folder.nil?

    # has share access if the folder is one of his own
    return true if self.folders.include?(folder)

    # has share access if the folder is one of the shared_folders_by_others
    return true if self.shared_folders_by_others.include?(folder)
    
    # for checking sub folders under one of the being_shared_folders
    return_value = false
    
    folder.ancestors.each do |ancestor_folder|
      return_value = self.being_shared_folders.include?(ancestor_folder)
      if return_value # if its true
        return true
      end
    end
    
    return false
  end


  # Facebook related
  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.displayname = auth.info.name
      user.gender = auth.info.gender if auth.info.gender
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.find_for_facebook_access_token(token)
    user = User.where(:fb_token => token).first
    
    unless user
      user = User.new(:fb_token => token)
      user.update_attrs_from_facebook
      
      # find uid exist or not
      exists_user = User.find_by(uid: user.uid)

      if exists_user.nil?
        user.provider = "facebook"
        user.save
      else
        user = exists_user
        user.update_column(:fb_token, token) unless user.fb_token == token || Rails.env.test?
        user.save if user.changed?
      end
    end
    user.update_access_fields
    user
  end

  def update_attrs_from_facebook
    begin
      data = graph_api.get_object('me')
      self.email        = data["email"]
      self.uid          = data["id"]
      self.name         = data["name"]
      self.gender       = data["gender"]     if data["gender"]
      self.display_name = data["name"]       if self.display_name.nil?

      if self.username.nil?
        if data["username"]
          self.username = data["username"]
        else
          self.username = "fb_#{data["id"]}"
        end
      end
    rescue Koala::Facebook::APIError => exc
      logger.error "Error upating from facebook #{self.inspect} - #{exc.message}"
    end
  end

  private
  def graph_api
    @graph ||= Koala::Facebook::API.new(self.fb_token)
  end
end
