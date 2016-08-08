class MessagesController < ApplicationController
  before_action :authenticate_user!, :set_chatroom

  def create
    @chatroom.messages.create! message_params.merge(user: current_user)
    redirect_to @chatroom
  end

  private

    def set_chatroom
      @chatroom = Chatroom.find params[:chatroom_id]
    end

    def message_params
      params.require(:message).permit(:body)
    end
end
