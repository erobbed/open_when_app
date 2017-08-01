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



  private
  def post_params
    params.require(:post).permit(:title, :content, :category_id, :sender_id, :recipient_id, :recipient_email, :read?, :read_time, tags_attributes: [:name])
  end
end


# <% if @recipient = User.find_by(email: :recipient_email) %>
#   <%= f.text_field :recipient_id, value: @recipient.id  %><br>
# <% else %>
#   <%= f.text_field :recipient_id, value: (
#   User.create(name: :recipient_email, email: :recipient_email, username: :recipient_name, password: "OpenWhen").id
#   )  %><br>
  # <% end %>



# create_table "posts", force: :cascade do |t|
#   t.string "title"
#   t.string "content"
#   t.integer "category_id"
#   t.integer "sender_id"
#   t.integer "recipient_id"
#   t.string "recipient_email"
#   t.boolean "read?", default: false
#   t.datetime "read_time"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end
