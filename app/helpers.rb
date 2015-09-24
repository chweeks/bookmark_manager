module Helpers

  def current_user
    current ||= User.first(id: session[:user_id])
  end

  def delete
      session[:user_id].delete
      flash.now[:notice] = ['goodbye!']
      redirect to('/sessions/new')
  end

end
