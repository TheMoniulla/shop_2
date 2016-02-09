class CommentsController < ApplicationController
  before_action :get_comment, only: [:edit, :update, :destroy]
  before_action :get_book
  before_action :authorize_destroy, only: :destroy
  before_action :authorize_update, only: [:edit, :update]


  def new
    @comment = @book.comments.new
  end

  def create
    @comment = @book.comments.new(comment_params.merge(user_id: current_user.id))
    if @comment.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes(comment_params)
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to book_path(@book)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def get_comment
    @comment = Comment.find(params[:id])
  end

  def get_book
    @book = Book.find(params[:book_id])
  end

  def authorize_destroy
    if @comment.user != current_user && !current_user.is_admin
      redirect_to book_path(@book), alert: 'you cannot destroy this comment'
    end
  end

  def authorize_update
    unless @comment.user == current_user
      redirect_to book_path(@book), alert: 'you cannot change this comment'
    end
  end
end