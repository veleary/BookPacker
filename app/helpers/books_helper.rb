module BooksHelper
  
  def create_box(id, weight)
    box = {"id" => id, "Total_Weight" => 0}
    @boxes << box      
    pack_books
  end

  def prepare_to_pack(books)
    @weights = []
    @book_titles = []
    books.each do |book|
      @weights << book.ship_weight 
      @book_titles << book.title
    end
    @boxes = []
    @empty_box = []
    @box_list = {}
    create_box(1, 0)
  end 

 def pack_books 
  @box = @boxes.last    
    @weights.each_with_index do  |weight, index|
      sum = weight.to_i + @box["Total_Weight"]
      if sum <= 10
        @box["Total_Weight"] += weight.to_i
        @box_list[@box["id"]] = Book.find_by_ship_weight(weight).title
        # @book_titles.delete_at(index)
        @weights.delete_at(index)
      else
        new_box_id = @box["id"] + 1
        create_box(new_box_id, 0)       
      end
    end
  end


  def packing_list
    return @boxes
    # return @box_list
  end
end
