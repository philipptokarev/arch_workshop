class Api::BooksController < Api::BaseController
  def index
    books = Book.with_pagination(params[:page])

    render_json(books, serializer: BookSerializer)
  end
end
