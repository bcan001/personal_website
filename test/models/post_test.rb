require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@post = Post.new(title: "this is a post", text: "this is the text of the post")
  end

  test "the post should be vaild" do
  	assert @post.valid?
  end

  test "title of the post should be at least 5 characters" do
  	@post.title = "yoyo"
  	# we expect this test to be FALSE
  	assert_not @post.valid?
  end


end
