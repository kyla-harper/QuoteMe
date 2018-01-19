# frozen_string_literal: true

module QuoteMe
  module QuoteMeEvents
    # Module for the Ready event
    module Ready
      extend Discordrb::EventContainer
      ready do |event|
        event.bot.game = CONFIG.game
      end
    end
  end
end
