class SubsController < ApplicationController
  before_action :require_logged_in, except: [:show, :index]
  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def update
    @sub = Sub.find_by(id: params[:id])
    if @sub && @sub.moderator == current_user
      if @sub.update_attributes(sub_params)
        redirect_to sub_url(@sub)
      else
        flash.now[:errors] = @sub.errors.full_messages
        render :edit
      end
    else
      flash.now[:errors] = ["You are not the moderator of this sub"]
      render :edit
    end
  end

  def destroy
    @sub = Sub.find_by(id: params[:id])
    if @sub && current_user == @sub.moderator
      @sub.destroy
      redirect_to subs_url
    else
      flash.now[:errors] = ["You can not delete a sub that you don't moderate"]
    end
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    render :edit
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
