class PostsController < ApplicationController

  def new
    @post = Post.new
    @post.tags.build(name: "tag1")
    @post.tags.build(name: "tag2")
  end

  def create
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :category_id, :sender_id, :recipient_id, :recipient_email, :read?, :read_time, tags_attributes: [:name])
  end
end

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
