class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end
  
  def index
    @users = User.all
    render :index
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
    render :show
  end
  
  def edit
    @user = User.find(params[:id])
    render :edit
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      flash[:errors] = @users.errors.full_messages
      redirect_to edit_user_url(@user)
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    
    if @user.delete
      redirect_to users_url
    else
      flash[:errors] = @users.errors.full_messages
      redirect_to edit_user_url(@user)
    end
  end
    
  private
  
  def user_params
    params.require(:user).permit(:email, :password)
  end
end