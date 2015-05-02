class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(form_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_path(@user)
    else
     #flash[:danger] = "Something went wrong"
      render :new
    end
  end

  private

  def form_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
