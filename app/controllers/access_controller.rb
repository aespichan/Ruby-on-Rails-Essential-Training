class AccessController < ApplicationController
  layout 'admin'

  before_action :confim_logged_in, except: %i[login attempt_login logout]

  def menu
    # menu form
  end

  def login
    # login form
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = AdminUser.where(username: params[:username]).first
      authorized_user = found_user.authenticate(params[:password]) if found_user
    end

    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = 'You are now logged in'
      redirect_to(admin_path)
    else
      flash.now[:notice] = 'Invalid username/password combination'
      render('login')
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = 'Logged out'
    redirect_to(access_login_path)
  end
end
