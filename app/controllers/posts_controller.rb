class PostsController < ApplicationController

  def new
    @post = Post.new
    @post.tags.build(name: "tag1")
    @post.tags.build(name: "tag2")
    all_senders_and_receivers = []
    current_user.posts.each do |post|
      all_senders_and_receivers << post.recipient_email
    end
    current_user.opens.each do |post|
      all_senders_and_receivers <<  User.find_by(id: post.sender_id).email
    end
    @uniq_senders_receivers = all_senders_and_receivers.uniq
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
      UserMailer.new_openwhen(@recipient).deliver_now
      flash[:send_success] = "Success! Your OpenWhen has been sent! Rejoice!"
      redirect_to '/'
    else
      flash[:send_failure] = "Unfortunately, you need some critical fields. Please try again!"
      redirect_to '/posts/new'
    end
  end

  def index
    if params[:q]
      if params["search_by"] == "sender"
        search_user = User.find_by(name: params[:q])
          if search_user
            @posts = Post.where(sender_id: search_user.id)
          else
            flash[:search] = "Sorry! Your search did not turn up any results."
            @posts = Post.all
            render :index
          end
      else
        #  params["search_by"] == "tag"
        search_tag = Tag.find_by(name: params[:q])
        if search_tag
          @posts = Post.all.select {|post| post.tags.where(tag_id: search_tag.id)}
        else
          flash[:search] = "Sorry! Your search did not turn up any results."
          @posts = Post.all
          render :index
        end
      end
    else
      @posts = Post.all.select {|post| post.recipient_id == current_user.id && post.category.id == params[:category_id].to_i}
    end
    # <%= form_tag(category_posts_path(params[:category_id]), method: "get") do %>
    # <%= label_tag(:q, "Search for") %>
    # <%= select_tag "search_by",options_for_select([ "tag", "sender" ], :search_input) %>
    # <%= text_field_tag(:q) %>
    # <%= submit_tag("Search") %>
    # <% end %>
    # <br>
    #
    #
    # ActionController::Parameters {"utf8"=>"✓", "search_by"=>"sender", "q"=>"dkjfsf", "commit"=>"Search", "controller"=>"posts", "action"=>"index", "category_id"=>"1"} permitted: false>
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
     if @post.read_time.nil?
       @post.read_time = Time.now
     end
    @post.save
    redirect_to post_path(@post)
  end

  def unread
    @post = Post.find(params[:id])
    @post.read_status = false
    @post.read_time = nil
    @post.save
    redirect_to category_posts_path(@post.category)
  end

  def all_posts
    @posts = Post.where(recipient_id: current_user.id)
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
