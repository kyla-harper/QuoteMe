# frozen_string_literal: false

module QuoteMe
  module QuoteMeCommands
    # Module for the quote commands
    module Quotes
      extend Discordrb::Commands::CommandContainer

      # List quotes command
      # COMING SOON TO A BOT NEAR YOU

      # Retrieve quote by name command
      command(%i[q quote quotebyname =],
              description: 'Retrives a random quote with the given name.',
              usage: "#{QUOTE_ME.prefix}quote <name>") do |event, quote|
        quote = Database::Quote.where(name: quote, server_id: event.server.id).all.sample
        "`##{quote.id}` - #{quote.name}\n#{quote.body}"
      end

      # Retrieve quote by id command
      command(%i[qi quoteid quotebyid #],
              description: 'Retrives the quote with the given ID.',
              usage: "#{QUOTE_ME.prefix}quoteid <id>") do |event, id|
        quote = Database::Quote.where(id: id, server_id: event.server.id).first
        "`##{quote.id}` - #{quote.name}\n#{quote.body}"
      end

      # Retrieve quote by author command
      command(%i[qa quoteauthor quotebyauthor @],
              description: 'Retrieves a random quote by the given user.',
              usage: "#{QUOTE_ME.prefix}quoteauthor <author>") do |event, author|
        quote = Database::Quote.where(added_by: author, server_id: event.server.id).all.sample
        "`##{quote.id}` - #{quote.name}\n#{quote.body}"
      end

      # Add quote command
      command(%i[addq addquote +],
              description: 'Adds a new quote with the given name.',
              usage: "#{QUOTE_ME.prefix}addquote <name> <body>") do |event, name, *body|
        quote = Database::Quote.new(name: name,
                                    server_id: event.server.id,
                                    added_by: event.author.username,
                                    body: body.join(' '))
        event.channel.send_embed do |embed|
          if quote.save
            embed.description = "#{event.author.mention} Quote successfully added with id `#{quote.id}`."
            embed.color = CONFIG.success_embed_color
          else
            embed.description = "#{event.author.mention} Unable to add quote."
            embed.color = CONFIG.error_embed_color
          end
        end
      end

      # Delete quote command
      command(%i[delq delquote deletequote -],
              description: 'Deletes the quote with the given name.',
              usage: "#{QUOTE_ME.prefix}deletequote <quoteid>") do |event, quoteid|
        quote = Database::Quote.where(id: quoteid).first

        event.channel.send_embed do |embed|
          embed.color = CONFIG.error_embed_color
          embed.description = "#{event.author.mention} "
          if quote.server_id != event.server.id
            embed.description << "That quote doesn't belong to this server"
          elsif !event.author.permission?('manage_messages', event.channel) &&
                event.author.username != quote.added_by
            embed.description << 'You need to be the quote author or have the '
            embed.description << 'manage messages permission to delete a quote.'
          elsif quote.delete
            embed.color = CONFIG.success_embed_color
            embed.description << "Successfully deleted quote #{quote.id}"
          else
            embed.description << 'An error ocurred while trying to delete this quote.'
          end
        end
      end

      # Delete all quotes command
      command(%i[deleteallquotes],
              description: 'Deletes all quotes associated with your server',
              usage: "#{QUOTE_ME.prefix}deleteallquotes") do |event, comfirmation|
        if !event.user.owner? # Must be server owner
          event << 'You must be the server owner in oder to run this command.'
        elsif comfirmation != '--no-preserve-root' # Need confirmation flag
          event << 'This is a very dangerous command that cannot be undone.'
          event << 'If you are absolutly sure that you want to delete every ' \
                   'quote on your server, run the command with the confirmation flag'
          event << "```#{QUOTE_ME.prefix}deleteallquotes --no-preserve-root```"
        else
          Database::Quote.where(server_id: event.server.id).delete
          event << 'All quotes belonging to you server have been deleted.'
        end
      end
    end
  end
end
