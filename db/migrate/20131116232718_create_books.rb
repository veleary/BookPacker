class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.decimal :price
      t.decimal :weight
      t.string :isbn
      t.timestamps
    end
  end
end
