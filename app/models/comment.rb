class Comment < ActiveRecord::Base
  validates :content, :post_id, :user_id, presence: true
  belongs_to :post
  belongs_to :user
  belongs_to(
   :parent,
   class_name: 'Comment',
   foreign_key: :parent_id,
   primary_key: :id
  )
end
