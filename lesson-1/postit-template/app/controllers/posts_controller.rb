class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
  	@posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = User.first # TODO: change once we have authentication
    # binding.pry
    # MEMORIZE the following pattern!
    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else    # validation error -> why we must render the errors
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Your post was updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private

  # strong parameters for security
  def post_params
    # params.require(:post).permit!
    # if user.admin?
    #   params.require(:post).permit!               # permits all attributes
    # else
    params.require(:post).permit(:title, :url, :description, category_ids: [])  # only permits certain attributes that you decide
    # end
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
