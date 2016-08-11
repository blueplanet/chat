class MessagesController < ApplicationController
  before_action :authenticate_user!, :set_chatroom

  def create
    message = @chatroom.messages.build message_params.merge(user: current_user)
    message.save

    MessageRelayJob.perform_later message
  end

  private

    def set_chatroom
      @chatroom = Chatroom.find params[:chatroom_id]
    end

    def message_params
      params.require(:message).permit(:body)
    end
end
