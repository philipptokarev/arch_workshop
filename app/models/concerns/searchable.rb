module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    scope :paginate, ->(page, sort: nil) do
      per_page = Settings.app.items_per_page
      pagination = {
        sort:,
        from: (page.to_i - 1) * per_page.to_i,
        size: per_page.to_i
      }.compact
      search(pagination)
    end
  end
end
