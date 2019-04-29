# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    flash[:notice] = if @post.save
                       'Post added'
                     else
                       @post.errors.full_messages.join('. ')
                     end

    redirect_to post_path(@post)
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
  end

  private

  def post_params
    params.require(:post).permit(:content, :title).merge(user_id: current_user.id)
  end
end
