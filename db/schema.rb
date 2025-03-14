# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_03_14_001648) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "admin_users", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "Учетные записи для системы администрирования", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
  end

  create_table "authors", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "Авторы книг", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false, comment: "Имя автора"
    t.string "last_name", comment: "Фамилия автора"
    t.string "middle_name", comment: "Отчество автора"
    t.string "original", comment: "Автор в inpx-индексе"
    t.integer "books_count", default: 0, null: false, comment: "Количество книг"
    t.index ["first_name", "last_name", "middle_name", "original"], name: "idx_on_first_name_last_name_middle_name_original_8ed0e1cb00", unique: true
  end

  create_table "book_likes", comment: "Лайки книг", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "folder", comment: "Имя папки"
    t.integer "book", comment: "Идентификатор книги в библиотеке"
    t.integer "total", comment: "Количество лайков"
  end

  create_table "books", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "Книги", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", null: false, comment: "Название"
    t.string "series", comment: "Серия"
    t.string "serno", comment: "Номер в серии"
    t.integer "libid", null: false, comment: "Идентификатор книги в библиотеке"
    t.integer "size", null: false, comment: "Размер файла в байтах"
    t.integer "filename", null: false, comment: "Название файла в архиве"
    t.boolean "del", default: false, null: false, comment: "Удален ли файл из библиотеки"
    t.string "ext", default: "fb2", null: false, comment: "Расширение файла"
    t.date "published_at", comment: "Дата публикации файла в библиотеке"
    t.string "insno", comment: "ISBN"
    t.uuid "folder_id", null: false
    t.uuid "language_id", null: false
    t.index ["folder_id"], name: "index_books_on_folder_id"
    t.index ["language_id"], name: "index_books_on_language_id"
  end

  create_table "books_authors", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "Связь книги с авторами", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "book_id", null: false
    t.uuid "author_id", null: false
    t.index ["author_id"], name: "index_books_authors_on_author_id"
    t.index ["book_id"], name: "index_books_authors_on_book_id"
  end

  create_table "books_genres", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "Связь книги с жанрами", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "book_id", null: false
    t.uuid "genre_id", null: false
    t.index ["book_id"], name: "index_books_genres_on_book_id"
    t.index ["genre_id"], name: "index_books_genres_on_genre_id"
  end

  create_table "books_keywords", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "Связь книги с ключевыми словами", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "book_id", null: false
    t.uuid "keyword_id", null: false
    t.index ["book_id"], name: "index_books_keywords_on_book_id"
    t.index ["keyword_id"], name: "index_books_keywords_on_keyword_id"
  end

  create_table "folders", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "Папки книг", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false, comment: "Название папки"
    t.index ["name"], name: "index_folders_on_name", unique: true
  end

  create_table "genre_groups", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "Группа жанров книг", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false, comment: "Название группы жанра"
    t.index ["name"], name: "index_genre_groups_on_name", unique: true
  end

  create_table "genres", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "Жанры книг", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", null: false, comment: "Обозначение жанра в библиотеке"
    t.string "name", comment: "Название жанра"
    t.uuid "genre_group_id", null: false
    t.integer "books_count", default: 0, null: false, comment: "Количество книг"
    t.index ["genre_group_id"], name: "index_genres_on_genre_group_id"
    t.index ["slug"], name: "index_genres_on_slug", unique: true
  end

  create_table "keywords", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "Ключевые слова", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false, comment: "Ключевое слово"
    t.integer "books_count", default: 0, null: false, comment: "Количество книг"
    t.index ["name"], name: "index_keywords_on_name", unique: true
  end

  create_table "languages", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "Языки книг", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", null: false, comment: "Обозначение языка"
    t.string "name", comment: "Название языка"
    t.integer "books_count", default: 0, null: false, comment: "Количество книг"
    t.index ["slug"], name: "index_languages_on_slug", unique: true
  end

  add_foreign_key "books", "folders"
  add_foreign_key "books", "languages"
  add_foreign_key "books_authors", "authors"
  add_foreign_key "books_authors", "books"
  add_foreign_key "books_genres", "books"
  add_foreign_key "books_genres", "genres"
  add_foreign_key "books_keywords", "books"
  add_foreign_key "books_keywords", "keywords"
  add_foreign_key "genres", "genre_groups"
end
