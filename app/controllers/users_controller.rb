class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

 
  def index
  	@users = User.all
    @user = current_user
    @books = @user.books
    @book = Book.new
  end

  def show
  	@user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(@user.id), notice: 'update successfully'
    else
      render :edit
    end
  end

  private
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image, :user_id)
	end

  def correct_user
      @user = User.find(params[:id])
      redirect_to user_path(current_user) unless @user == current_user
  end
end
