Bookpacker::Application.routes.draw do
  root book_index_path
 resources :book

end
