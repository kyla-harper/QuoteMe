# frozen_string_literal: false

module QuoteMe
  module QuoteMeCommands
    # Module for the config commands
    module Configuration
      extend Discordrb::Commands::CommandContainer
      # toggleimportnadeko command
      command(:toggleimportnadeko) do |event|
        server = Database::ServerConfig.where(server_id: event.server.id).first
        server.import_nadeko = !server.import_nadeko
        server.save

        event.channel.send_embed do |embed|
          embed.color = CONFIG.success_embed_color
          embed.description = if server.import_nadeko
                                'Now '
                              else
                                'No longer '
                              end
          embed.description << 'attempting to import quotes from Nadeko'
        end
      end
    end
  end
end
