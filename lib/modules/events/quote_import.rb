# frozen_string_literal: true

module QuoteMe
  module QuoteMeEvents
    # Module for handling the message event
    module ImportNadeko
      extend Discordrb::EventContainer
      message(from: 116_275_390_695_079_945,
              starts_with: /`\#[0-9]*\ added\ by\ /) do |event|
        if Database::ServerConfig.where(server_id: event.server.id)
                                 .get(:import_nadeko)
          # Extract quote into parts
          #
          # Structure of split quote looks like:
          # # ["`id", "added", "by", "user`", "emoji", "a:", "body1".."bodyn"]
          parts = event.content.split(' ')
          author = parts[3].chop
          name = parts[5].chop
          parts.slice! 0..5
          body = parts.join ' '

          # Create and Save the new quote
          quote = Database::Quote.new(name: name,
                                      server_id: event.server.id,
                                      added_by: author,
                                      body: body)
          event.channel.send_embed do |embed|
            if quote.save
              embed.description = 'Quote successfully imported.'
              embed.color = CONFIG.success_embed_color
            else
              embed.description = 'Unable to import quote.'
              embed.color = CONFIG.error_embed_color
            end
          end
        end
      end
    end
  end
end
