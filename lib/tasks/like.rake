namespace :like do
  desc 'Like a book'
  task send: :environment do
    book = Book.all.sample

    Karafka.producer.produce_sync(
      topic: 'book_likes',
      payload: { folder: book.folder.name, book: book.libid }.to_json
    )
  end
end
