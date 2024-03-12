class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @book = current_user.books.build
  end
  
  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to book_path(@book), notice: "Book was successfully created."
    else
      @books = Book.all
      render 'index' 
    end
  end
  
  def index
      @books = Book.all
  end

  def show
    @book = Book.find_by(id: params[:id])
    if @book.nil?
      redirect_to books_path, alert: "Book not found."
    end
  end
  
  def edit
  @book = Book.find_by(id: params[:id])
  if @book.nil? || @book.user != current_user
    redirect_to books_path, alert: "Book not found or you don't have permission to edit this book."
  end
  end
　


  def update
    @book = Book.find_by(id: params[:id])
    if @book.nil? || @book.user != current_user
      redirect_to books_path, alert: "Book not found."
    else
      if @book.update(book_params)
        redirect_to book_path(@book), notice: "Book was successfully updated."
      else
        render 'edit'
      end
    end
  end
  
  def destroy
    @book = Book.find_by(id: params[:id])
    if @book.nil?
      redirect_to books_path, alert: "Book not found."
    else
      @book.destroy
      redirect_to books_path, notice: "Book was successfully deleted."
    end
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
