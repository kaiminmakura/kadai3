class BooksController < ApplicationController

	before_action :authenticate_user!

	def create
		@books = Book.all
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			flash[:success] = 'successfully'
			redirect_to book_path(@book)
	    else
	    	render :index
		end
	end

	def index
		@books = Book.all
		@user = current_user
		@book = Book.new
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:success] = 'successfully'
			redirect_to book_path(@book)
		else
			render :edit
		end

	end

	def show
		@books = Book.find(params[:id])
		@user = @books.user
		@book = Book.new
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
