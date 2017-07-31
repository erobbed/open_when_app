# class Open < ApplicationRecord
#
#   belongs_to :post
#   belongs_to :recipient, :class_name => "User"
#
#
# end




class Post < ApplicationRecord
  has_many :post_tags
  has_many :tags, through: :post_tags
  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"
  belongs_to :category
  accepts_nested_attributes_for :tags

end
