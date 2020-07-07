class BooksController < ApplicationController

	before_action :authenticate_user!

	def index
		@books = Book.all
		@user = current_user
		@book = Book.new
	end


	def create
		@books = Book.all
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			redirect_to book_path(@book), notice: 'post successfully'
	    else
	    	@user = User.find(current_user.id)
	    	@books = Book.all
	    	render :index
		end

	end



	def edit
		@book = Book.find(params[:id])
		if @book.user != current_user
			redirect_to books_path
		end
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			redirect_to book_path(@book.id), notice: 'update successfully'
		else
			render :edit
		end

	end

	def show
		@books = Book.find(params[:id])
		@user = @books.user
		@book = Book.new
		@book_comment = BookComment.new
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to user_path(current_user.id)
	end

	private
	def book_params
		params.require(:book).permit(:title, :body, :user_id)
	end
end
