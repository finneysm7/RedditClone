class Sub < ActiveRecord::Base
  validates :title, :user_id, presence: true
  
  belongs_to(
     :moderator,
     class_name: 'User',
     foreign_key: :user_id,
     primary_key: :id
   )
   
  has_many :posts
end
