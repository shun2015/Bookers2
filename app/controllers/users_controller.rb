class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user,only: [:edit]
  
  def index
    @users = User.all
    @book = Book.new
    @user = User.find(current_user.id)
  end
  
  def show
    
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  def correct_user
        @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
