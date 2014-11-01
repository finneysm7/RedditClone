class Post < ActiveRecord::Base
  
  validates :title, :user_id, presence: true
  #belongs_to :sub
  belongs_to :user
  has_many :post_subs
  has_many :subs, through: :post_subs, source: :sub
  
end
