class User < ApplicationRecord
  has_many :posts, :foreign_key => 'sender_id'
  has_many :opens, :foreign_key => 'recipient_id', :class_name => "Post"
  has_many :categories, through: :opens
  # looking at all the categories for which a person has received an OpenWhen
  has_many :visits

  has_secure_password

  validates :name, :username, :email, presence: true
  validates :username, uniqueness: true
  validates :email, uniqueness: true



  def average_duration
    if self.visits.count > 1
      user_durations = self.visits[0...-1].map {|visit| (visit.ended_at - visit.started_at)/60}
      total_user_duration = user_durations.inject(:+)
      (total_user_duration / self.visits[0...-1].count).round(2)
    else
      total_user_duration = (Time.now - self.visits[0].started_at)/60
    end
  end

  def max_duration
    if self.visits.count > 1
      user_durations = self.visits[0...-1].map {|visit| (visit.ended_at - visit.started_at)/60}
      user_durations.max.round(2)
    else
      user_duration = (Time.now - self.visits[0].started_at)/60
    end
  end


end
