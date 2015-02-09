class PostsController < ApplicationController
	# R of crud
	def index
		@posts = Post.all
	end
	# R of crud
	def show
		@post = Post.find(params[:id])

	end

	# C of crud
	def new
		@post = Post.new
	end

	# U of crud
	def edit
  	@post = Post.find(params[:id])
	end

	# C of crud
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

	# U of crud
	def update
		@post = Post.find(params[:id])
 
  	if @post.update(post_params)
    	redirect_to @post
  	else
    	render 'edit'
  	end
	end

	# D of crud
	def destroy
  	@post = Post.find(params[:id])
  	@post.destroy
 
  	redirect_to posts_path
	end



	private
		def post_params
			params.require(:post).permit(:title, :text)
		end

end