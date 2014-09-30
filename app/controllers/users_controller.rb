class UsersController < ApplicationController
  #before_filter :authenticate_user!

  def self.all_users
    @users = User.all
  end

  def index
    @users = User.includes(:events).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @user = User.includes(:events).find(params[:id])
    #unless @user == current_user
    #  redirect_to :back, :alert => "Access denied."
    #end
  end

end
