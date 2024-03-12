class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end
  
  def index
    @users = User.includes(:books)
  end

  def edit
    if @user != current_user
      redirect_to root_path, alert: "You are not authorized to edit this user."
    end
  end

  def update
    if @user != current_user
      redirect_to root_path, alert: "You are not authorized to edit this user."
      return
    end

    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "User was successfully created."
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

