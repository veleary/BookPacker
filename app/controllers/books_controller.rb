class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  require 'nokogiri'
  # GET /books
  # GET /books.json
  def index
    @book = Nokogiri::HTML(openFile.read("data/book1.html")))
    @books = Book.all
  end

  def read_booklist(filename)
    @book1 = Nokogiri::HTML(File.read("/data/#{filename}"))
  end

  def get_product_details(book)
    book_title = book.at_css("strong:nth-child(1) a").text
    book_author = book.at_css(".buying span a").text
    book_price = book.at_css(".listprice").text
    book_ship_weight = book.at_css("#productDetailsTable li:nth-child(7)").text
    book_isbn10 = book.at_css("#productDetailsTable li:nth-child(4)").text
    book_isbn13 = book.at_css("#productDetailsTable li:nth-child(5)").text
    book_total_pages = book.at_css("#productDetailsTable li:nth-child(1)").text
    book_publisher = book.at_css("#productDetailsTable li:nth-child(2)").text
    book_language = book.at_css("#productDetailsTable li:nth-child(3)").text
    book_description = book.at_css("#postBodyPS div").text    
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render action: 'show', status: :created, location: @book }
      else
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params[:book]
    end
end
