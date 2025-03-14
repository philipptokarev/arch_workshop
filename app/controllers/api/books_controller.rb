class Api::BooksController < Api::BaseController
  def index
    books = Book.order(published_at: :desc).paginate(page)
    # Использовать методы от kaminari?
    # Book.order(published_at: :desc).page(page).per(Settings.app.items_per_page)
    render_json(books, serializer: BookSerializer)
  end
end
