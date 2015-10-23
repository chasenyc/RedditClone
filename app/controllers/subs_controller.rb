class SubsController < ApplicationController

  before_action :require_sub_owner, only: [:edit]

  def new
    @sub = Sub.new
  end

  def index
    @subs = Sub.all
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def edit
    @sub ||= Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    @sub.update(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def require_sub_owner
    @sub = Sub.find(params[:id])
    unless current_user.id == @sub.user_id
      redirect_to
      sub_url(@sub)
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
