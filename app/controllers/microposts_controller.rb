class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "New micropost added."
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted successfully"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def correct_user
    @micropost = Micropost.find_by(id: params[:id])
    if @micropost.nil?
      flash[:danger] = "You don't have permission to do that"
      redirect_to :back
    elsif current_user.id != @micropost.user_id
      flash[:danger] = "You don't have permission to do that"
      redirect_to :back
    end
  end

end
