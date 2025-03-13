RSpec.describe Api::BooksController, type: :controller do
  describe 'GET /index' do
    let(:folder) { create(:folder) }
    let(:author) { create(:author) }
    let(:language) { create(:language) }
    let(:genre) { create(:genre) }
    let(:keyword) { create(:keyword) }
    let!(:books) do
      create_list(
        :book_with_authors,
        Settings.app.items_per_page + 1,
        authors: [ author ], genres: [ genre ], keywords: [ keyword ],
        folder:, language:
      )
    end

    shared_examples :get_index do |params, expected_count|
      it "Ожидаемо кол-во записей #{expected_count}" do
        get(:index, params:)

        expect(response_as_json[:result].count).to eq(expected_count)
      end
    end

    it_behaves_like :get_index, nil, Settings.app.items_per_page
    it_behaves_like :get_index, { page: -2 }, Settings.app.items_per_page
    it_behaves_like :get_index, { page: 'dsa21' }, Settings.app.items_per_page
    it_behaves_like :get_index, { page: 2 }, 1
  end
end
