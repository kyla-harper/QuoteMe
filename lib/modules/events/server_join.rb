# frozen_string_literal: true

module QuoteMe
  module QuoteMeEvents
    # Module for the Server Join event
    module ServerJoin
      extend Discordrb::EventContainer
      server_create do |event|
        # Use the ready event to make sure every server we are on has a record
        # in the server_config table
        conf = Database::ServerConfig.where(server_id: event.server.id).first
        Database::ServerConfig.create server_id: event.server.id if conf.nil?
      end
    end
  end
end
