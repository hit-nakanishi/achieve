class MessagesController < ApplicationController

  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  
  def index
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    if @messages.last
      if @messages.last.user_id != current_user.id
       @messages.last.read = true
      end
    end

    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)

    if @conversation.recipient_id == current_user.id
      @notification = @message.notifications.build(recipient_id: @conversation.sender_id, sender_id: current_user.id, conversation_id: @conversation.id)
    else
      @notification = @message.notifications.build(recipient_id: @conversation.recipient_id, sender_id: current_user.id, conversation_id: @conversation.id)
    end

    if @message.save
      if @conversation.recipient_id == current_user.id
        Pusher.trigger(['notifications'+@message.conversation.sender_id.to_s],'message', {messaging: "メッセージが届いています。：#{@message.body}"})
      else
        Pusher.trigger(['notifications'+@message.conversation.recipient_id.to_s],'message', {messaging: "メッセージが届いています。：#{@message.body}"})
      end

      redirect_to conversation_messages_path(@conversation)
    end
  end
  
  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
