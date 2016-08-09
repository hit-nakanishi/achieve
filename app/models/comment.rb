class Comment < ActiveRecord::Base
  validates :content, presence: true
  
  belongs_to :blog
  belongs_to :user
  
  has_many :notifications, dependent: :destroy
  has_many :conversations, through: :notifications, source: :comment

  accepts_nested_attributes_for :notifications

  def comment_time
    created_at.strftime("%y/%m/%d %p %l:%M")
  end

end
