class CreateBookLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :book_likes, comment: 'Лайки книг', force: :cascade do |t|
      t.timestamps

      t.string :folder, comment: 'Имя папки'
      t.integer :book, comment: 'Идентификатор книги в библиотеке'
      t.integer :total, comment: 'Количество лайков'
    end
  end
end
