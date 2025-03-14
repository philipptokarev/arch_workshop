# frozen_string_literal: true

class BookLikesConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      book = BookLike.find_or_create_by(
        message.payload.slice('folder', 'book')
      ).increment!(:total)

      Karafka.logger.info("Book like for #{message.payload['folder']} #{message.payload['book']}")
    end
  end

  # Run anything upon partition being revoked
  # def revoked
  # end

  # Define here any teardown things you want when Karafka server stops
  # def shutdown
  # end
end
