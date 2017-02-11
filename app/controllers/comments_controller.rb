class CommentsController < ApplicationController
	# choose one of the methods depending ao application needs
	before_action :load_commentable_first
	#before_action :load_commentable_second

  def index
  	@comments = @commentable.comments
  end

  def new
  	@comment = @commentable.comments.new
  end

  def create
  	@comment = @commentable.comments.new(comment_params)

  	if @comment.save
  		redirect_to @commentable, notice: "Comment created."
  	else

  	end
  end

  private 

  # first version of this method introduces a lot of coupling between a controller and format of URL
  def load_commentable_first
  	# /photos/1, or /articles/2,...
  	resource, id = request.path.split('/')[1,2]

  	# photos -> photo -> 'Photo' -> Photo -> Photo.find
  	@commentable = resource.singularize.classify.constantize.find(id)
  end

  # version for a custom URL format
  def load_commentable_second
  	# c.name.underscore -> Article -> 'Article' -> 'article'
  	klass = [Article, Photo, Event].detect { |c| params["#{c.name.underscore}_id"] }
  	@commentable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def comment_params
  	params.require(:comment).permit(:content)
  end
end
