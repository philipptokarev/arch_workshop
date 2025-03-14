FactoryBot.define do
  factory :book_like do
    folder
    book
    total { 1 }
  end
end
