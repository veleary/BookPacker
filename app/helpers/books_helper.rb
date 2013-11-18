module BooksHelper
  
  def create_box(id, weight)
    box = {"id" => id, "Total_Weight" => 0}
    @boxes << box
    if @boxes.length == 1
      pack_books
    else @boxes.length < 100
      pack_books
    end
  end

  def prepare_to_pack(books)
    @weights = []
    books.each do |book|
      @weights << book.ship_weight 
    end
    @boxes = []
    @empty_box = []
    create_box(1, 0)
  end 

 def pack_books
    box = @boxes.last 
    @weights.each_with_index do  |weight, index|
      if weight.to_i + box["Total_Weight"].to_i <= 10
        box["Total_Weight"] += weight.to_i
        @weights.delete_at(index)
      else
        new_box_id = @boxes.length + 1
        create_box(new_box_id, weight)       
      end
    end
 end


 def packing_list
  return @boxes
 end  
end
