class LogoutController < ApplicationController

  def index
    session.delete(:session_id)
    redirect_to root_path
  end

end
