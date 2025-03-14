class Book < ApplicationRecord
  include Ransackable
  include Searchable

  has_many :books_authors, dependent: :destroy
  has_many :authors, through: :books_authors
  accepts_nested_attributes_for :authors

  has_many :books_genres, dependent: :destroy
  has_many :genres, through: :books_genres
  accepts_nested_attributes_for :genres

  has_many :books_keywords, dependent: :destroy
  has_many :keywords, through: :books_keywords
  accepts_nested_attributes_for :keywords

  belongs_to :folder # , counter_cache: :books_count
  belongs_to :language # , counter_cache: :books_count

  validates :title, :libid, :size, :filename, presence: true

  PUBLIC_FIELDS = %w[id del ext filename folder_id id_value insno
                     language_id libid series serno size title
                     published_at updated_at created_at]
  RANSACK_ASSOCIATIONS = %w[authors books_authors books_genres books_keywords
                            folder genres keywords language]

  scope :with_pagination, ->(page) do
    # Если прописать все поля, как во всем связанных сериалайзерах,
    # то можно ли будет `search(query).records` передавать в сериалайзер?
    book_ids = paginate(page, sort: [{ published_at: { order: :desc } }]).pluck(:_id)
    where(id: book_ids).includes(
      :authors, :folder, :genres, :keywords, :language
    ).order(published_at: :desc)
  end
end
