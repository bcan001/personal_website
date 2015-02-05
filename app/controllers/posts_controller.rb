class PostsController < ApplicationController
	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id])

	end

	def new
	end
	# create action is sending the new blog post to the database
	def create
		#render plain: params[:post].inspect
		@post = Post.new(post_params)
		if @post.save
			redirect_to :action => 'show', :id => @post.id
		else
			render 'new'
		end
	end

	private
		def post_params
			params.require(:post).permit(:title, :text)
		end

end