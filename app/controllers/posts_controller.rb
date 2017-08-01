class PostsController < ApplicationController

  def new
    @post = Post.new
    @post.tags.build(name: "tag1")
    @post.tags.build(name: "tag2")
  end

  def create
    if @recipient = User.find_by(email: params[:post][:recipient_email])
      params[:post][:recipient_id] = @recipient.id
    else
      @recipient = User.create(name: params[:post][:recipient_email], email: params[:post][:recipient_email], username: params[:post][:recipient_email], password: "OpenWhen")
      params[:post][:recipient_id] = @recipient.id
    end
    @post = Post.new(post_params)
    if @post.save
      flash[:send_success] = "Success! Your OpenWhen has been sent! Rejoice!"
      redirect_to '/'
    else
      flash[:send_failure] = "Unfortunately, you need some critical fields. Please try again!"
      redirect_to '/posts/new'
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      redirect_to edit_post_path(@post)
    end
  end

  def read
    @post = Post.find(params[:id])
    @post.read_status = true
    @post.read_time = Time.now
    @post.save
    redirect_to post_path(@post)
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :category_id, :sender_id, :recipient_id, :recipient_email, :read_status, :read_time, tags_attributes: [:name])
  end
end


# create_table "posts", force: :cascade do |t|
#   t.string "title"
#   t.string "content"
#   t.integer "category_id"
#   t.integer "sender_id"
#   t.integer "recipient_id"
#   t.string "recipient_email"
#   t.boolean "read_status", default: false
#   t.datetime "read_time"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end
