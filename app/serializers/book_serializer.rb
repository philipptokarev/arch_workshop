class BookSerializer
  include Alba::Resource

  attributes :id, :title, :series, :serno, :size, :del, :published_at, :insno
  attribute :filename do |book|
    "#{book.folder.name}/#{book.filename}.#{book.ext}"
  end
  many :authors
  many :genres
  many :keywords
  one :language
end
