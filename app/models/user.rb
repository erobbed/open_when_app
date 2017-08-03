class User < ApplicationRecord
  has_many :posts, :foreign_key => 'sender_id'
  has_many :opens, :foreign_key => 'recipient_id', :class_name => "Post"
  has_many :visits

  has_secure_password

  validates :name, :username, :email, presence: true
  validates :username, uniqueness: true
  validates :email, uniqueness: true



  def average_duration
    user_durations = self.visits[0...-1].map {|visit| (visit.ended_at - visit.started_at)/60}
    total_user_duration = user_durations.inject(:+)
    (total_user_duration / self.visits[0...-1].count).round(2)
  end

  def max_duration
    user_durations = self.visits[0...-1].map {|visit| (visit.ended_at - visit.started_at)/60}
    user_durations.max.round(2)
  end


end
