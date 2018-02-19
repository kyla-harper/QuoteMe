# frozen_string_literal: true

module QuoteMe
  module QuoteMeCommands
    # Module for the help commands
    module Help
      extend Discordrb::Commands::CommandContainer
      # Help command
      command(%i[h help],
              description: 'Sends instructions on how to use the bot',
              usage: "#{QUOTE_ME.prefix}help") do |event|
        event << '**Welcome to the Quote Me help.**'
        event << ''
        event << "*All commands are prefixed with: `#{QUOTE_ME.prefix}`*"
        event << '```'
        event << 'These are the basic commands:'
        event << '  •`quote <name>` - gets a quote by name'
        event << '    ◦ Aliased as: `q`, `quotebyname`, `=`'
        event << '  •`quoteid <id>` - gets a quote by id'
        event << '    ◦ Aliased as: `qi`, `quotebyid`, `#`'
        event << '  •`quoteauthor <author>` - gets a quote by author'
        event << '    ◦ Aliased as: `qa`, `quotebyauthor`, `@`'
        event << '  •`allquotesbyname <name>` - gets all quotes with given name'
        event << '    ◦ Aliased as: `an`, `allbyname`'
        event << '  •`addquote <name> <body>` - adds a new quote'
        event << '    ◦ Aliased as: `addq`, `+`'
        event << '  •`delquote <id>` - deletes the quote with the given id'
        event << '    ◦ Aliased as: `delq`, `deletequote`, `-`'
        event << '```'
        event << 'Check out the full list of commands at:'
        event << "<#{CONFIG.commands_url}>"
      end

      # Ping command
      command(:ping,
              description: 'Pings the bot to make sure it is alive',
              usage: "#{QUOTE_ME.prefix}ping") do |event|
        event.channel.send_embed do |embed|
          embed.title = 'Pong!'
          embed.color = CONFIG.success_embed_color
          delay = "#{((Time.now - event.timestamp) * 1000).to_i}ms"
          embed.description =
            "#{event.author.mention} "\
            ":ping_pong: #{delay}"
        end
      end
    end
  end
end
