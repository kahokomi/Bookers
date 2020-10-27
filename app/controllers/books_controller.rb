class BooksController < ApplicationController
  def index
    @books = Book.all.order(id: :asc)
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book), notice: "Book was successfully created."
    else @books = Book.all.order(id: :asc)
      render :index
    end
  end

  def edit
     @book = Book.find(params[:id])
  end

  def update
      @book = Book.find(params[:id])
        if @book.update(book_params)
          flash[:notice] = "Book was successfully updated."
          redirect_to book_path(@book)
        else
          render action: :edit
        end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      flash[:notice] = "Book was successfully destroyed."
      redirect_to books_path
    else
      render action: :index
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end