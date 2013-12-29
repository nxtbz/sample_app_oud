class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :udpate]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page], :per_page => 10)
   end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], :per_page => 25)
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:succes] ="User is destroyed"
    redirect_to user_url
  end

  def create
    @user = User.new(user_params)
    if @user.save
    	flash.now[:success] = "Welcome to the sample app"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def admin_user
      redirect_to(root_url) unless current_user.admin? 
    end


    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    #before filters


    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end


 end
