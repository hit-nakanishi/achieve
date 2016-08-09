class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  has_many :notifications, dependent: :destroy

  validates_presence_of :body, :conversation_id, :user_id

  accepts_nested_attributes_for :notifications

  def message_time
    created_at.strftime("%y/%m/%d at %l:%M %p")
  end
end
