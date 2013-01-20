class ApplicationController < ActionController::Base
  before_filter :auth, :response
  protect_from_forgery

  protected
  
  def succ(data)
    if data
      {:status => 'succ', :data => data}
    else
      {:status => 'succ'}
    end
  end

  def fail(msg)
    if msg
      {:status => 'fail', :msg => msg}
    else
      {:status => 'fail'}
    end
  end

  def respond_succ(data=nil)
    render :json => succ(data)
  end

  def respond_fail(msg=nil)
    render :json => fail(msg)
  end

  def auth
    if session[:user_id] 
      @user = User.find(session[:user_id])
      if @user
        @user_id = session[:user_id]
      else
        session[:user_id] = nil
        respond_fail 'need_login'
      end
    else
      respond_fail 'need_login'
    end
  end

end
