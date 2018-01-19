# frozen_string_literal: true

require 'discordrb'
require 'ostruct'
require 'yaml'

# Main bot module
module QuoteMe
  # Set up constants
  CONFIG = OpenStruct.new YAML.load_file 'lib/data/config.yml'
  QUOTE_ME = Discordrb::Commands::CommandBot.new(client_id: CONFIG.client_id,
                                                 token: CONFIG.token,
                                                 prefix: CONFIG.prefix,
                                                 fancy_log: CONFIG.fancy_log)
  INVITE_URL = "#{QUOTE_ME.invite_url}&permissions=#{CONFIG.permissions}"

  # Log some welcome messages
  Discordrb::LOGGER.info 'Welcome to Quote Me!'
  Discordrb::LOGGER.info 'Use ctrl+C to safely exit.'
  Discordrb::LOGGER.info "Use this link to invite your bot: #{INVITE_URL}"

  # Load non-discord modules
  Dir['lib/modules/*.rb'].each { |mod| load mod }

  # Load discord modules
  def self.load_module(name, path)
    new_module = Module.new
    const_set name, new_module
    Dir["lib/modules/#{path}/*.rb"].each { |file| load file }
    new_module.constants.each do |mod|
      QUOTE_ME.include! new_module.const_get(mod)
    end
  end
  load_module :QuoteMeEvents, 'events'
  load_module :QuoteMeCommands, 'commands'

  # Cleanly exit on interrupt
  Signal.trap 'INT' do
    Discordrb::LOGGER.info 'Exiting....'
    Discordrb::LOGGER.info 'Have a nice day!'
    # rubocop:disable Lint/HandleExceptions
    begin
      QUOTE_ME.stop
    rescue ThreadError
      # This is okay - we're going to exit anyways!
    end
    # rubocop:enable Lint/HandleExceptions
    exit
  end

  QUOTE_ME.run
end
