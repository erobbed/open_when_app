class User < ApplicationRecord
  has_many :posts, :foreign_key => 'sender_id'
  has_many :opens, :foreign_key => 'recipient_id', :class_name => "Post"
  has_many :visits

  has_secure_password

  validates :name, :username, :email, presence: true
  validates :username, uniqueness: true
  validates :email, uniqueness: true



end
