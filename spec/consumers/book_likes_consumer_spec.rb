RSpec.describe BookLikesConsumer do
  describe '#consume' do
    let(:book) { create(:book_with_authors) }
    let(:payload) { { 'folder' => book.folder.name, 'book' => book.libid } }
    let(:message) do
      msg = Karafka::Messages::Message.new(
        payload.to_json,
        Karafka::Messages::Metadata.new(
          offset: 0,
          partition: 0,
          topic: 'book_likes',
          timestamp: Time.now
        )
      )
      msg.instance_variable_set(:@payload, payload)
      msg.instance_variable_set(:@deserialized, true)
      msg
    end

    subject(:consumer) do
      instance = described_class.new
      instance.messages = [message]
      instance
    end

    it 'creates book like' do
      expect { consumer.consume }.to change(BookLike, :count).by(1)
    end

    context 'when book like already exists' do
      let!(:book_like) { create(:book_like, **payload.slice('folder', 'book')) }

      it 'increments book like' do
        expect { consumer.consume }.to change(BookLike, :count).by(0)
        expect(book_like.reload.total).to eq(2)
      end
    end
  end
end
