module Pagination
  extend ActiveSupport::Concern

  included do
    scope :paginate, ->(page) do
      per_page = Settings.app.items_per_page
      limit(per_page).offset((page - 1) * per_page)
    end
  end
end
