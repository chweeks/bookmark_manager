module Sinatra
  module BookmarkManager
    module Controllers
      module Sessions

        def self.registered(app)

          show_login = lambda do
            erb :'sessions/new'
          end

          login = lambda do
            user = User.authenticate(params[:email], params[:password])
            if user
              session[:user_id] = user.id
              redirect to('/links')
            else
              flash.now[:errors] = ['The email or password is incorrect']
              erb :'sessions/new'
            end
          end

          log_out = lambda do
            session[:user_id] = nil
            flash.next[:notice] = 'goodbye!'
            redirect to('/sessions/new')
          end

          app.get '/sessions/new', &show_login
          app.post '/sessions', &login
          app.delete '/sessions', &log_out

        end
      end
    end
  end
end
