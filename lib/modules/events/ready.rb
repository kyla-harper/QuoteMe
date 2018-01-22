# frozen_string_literal: true

module QuoteMe
  module QuoteMeEvents
    # Module for the Ready event
    module Ready
      extend Discordrb::EventContainer
      ready do |event|
        event.bot.game = CONFIG.game

        # Use the ready event to make sure every server we are on has a record
        # in the server_config table
        event.bot.servers.each_key do |server|
          conf = Database::ServerConfig.where(server_id: server).first
          Database::ServerConfig.create server_id: server if conf.nil?
        end
      end
    end
  end
end
