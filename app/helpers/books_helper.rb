module BooksHelper
   def prepare_to_pack(books)
  items = {}
  books.each do |book|
    items[book.title] = book.ship_weight 
  end
  return items
 end 

 def pack_books(items)
  boxes = {"Total_Weight" => 0, "Contents" => "Title: "}
  items.each do |key, value|
    if value.to_f + boxes["Total_Weight"].to_f <= 10
      boxes["Contents"] += ", " + key
      boxes["Total_Weight"] += value.to_f
    end
  end
  return boxes
 end  
end
