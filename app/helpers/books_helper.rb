module BooksHelper
  
  def create_box(id, weight, content)
    box = {"id" => id, "Total_Weight" => 0, "Contents" => content}
    @boxes << box
    # @boxes.each do |box|
    #   if box["Total_Weight"] <= 10
    #     @empty_box << box
    #   end
    # end
    pack_books
  end

  def prepare_to_pack(books)
    @items = {}
    books.each do |book|
      @items["Title"] = book.title
      @items["Shipping_Weight"] = book.ship_weight 
    end
    @boxes = []
    @empty_box = []
    create_box(1, 0 , "Title ")
  end 

 def pack_books 
    box = @boxes.last 
    @items.each do |item| 
      if item["Shipping_Weight"].to_f + box["Total_Weight"].to_f <= 10
        box["Contents"] += ", " + item["Title"]
        box["Total_Weight"] += item["Shipping_Weight"].to_f
      else
        new_box_id = @boxes.length + 1
        create_box(new_box_id, item["Shipping_Weight"].to_f, item["Title"])      
      end
    end
 end

 #  def prepare_to_pack(books)
 #    @items = []
 #    books.each do |book|
 #      @items << book.ship_weight 
 #    end
 #    create_box(1, 0 , "Title ")
 #  end 

 # def pack_books
 #    box_total = 0  
 #    @items.each do |weight| 
 #     if box_total + weight <= 10
 #          box_total += weight
 #        else
 #          new_box_id = @boxes.length + 1
 #          create_box(new_box_id, value.to_f, key)      
 #        end
 #      end
 #    end
 # end

 # def pack
 #    @box = {}
 #    @box["total_weight"] = 0
 #    @books.each do |book|
 #      if book.ship_weight + @box["total_weight"] <= 10
 #        @box["total_weight"] += book.ship_weight
 #        @box["Titles"] += ", " + book.title
 #      else
 #        @new_box = {}
 #        @new_box["total_weight"] = book.ship_weight
 #        @new_box["title"] = book.title
 #       end
 #  end

 def packing_list
  return @boxes
 end  
end
