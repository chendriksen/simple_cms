require 'digest/sha1'
class AdminUser < ActiveRecord::Base
  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, :through => :section_edits
  scope :named, lambda {|first,last| where(:first_name => first, :last_name => last)}
  
  attr_accessor :password
  
  def self.authenticate(username ="", password="")
    user = AdminUser.find_by_username(username)
    if user && user.password_match?(password)
      return user
    else
      return false
    end
  end
  
  def password_match?(password="")
    hashed_password == AdminUser.hash_with_salt(password, salt)
  end
  
  validates :first_name, :presence => true, :length => { :maximum => 25 }
  validates :last_name, :presence => true, :length => { :maximum => 50 }
  validates :username, :length => { :within => 8..25 }, :uniqueness => true
  validates :email, :presence => true, :length => { :maximum => 100 }, :confirmation => true
  
  validates_length_of :password, :within => 8..25, :on => :create
  
  before_save :create_hashed_password
  after_save :clear_password 
   
  def self.make_salt(username="")
    Digest::SHA1.hexdigest("User #{username} with #{Time.now} to make salt")
  end
  
  def self.hash_with_salt(password="", salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end
  
  attr_protected :hashed_password, :salt
  
  private
  
  def create_hashed_password
    # Whenever :password has a value hashing is needed
    unless password.blank?
      # Always use "self" when assigning values
      self.salt = AdminUser.make_salt(username) if salt.blank?
      self.hashed_password = AdminUser.hash_with_salt(password, salt)
    end
  end
  
  def clear_password
    # for security and because hasing is not needed
    self.password = nil
  end
   
end
require "subject"
