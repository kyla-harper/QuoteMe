# frozen_string_literal: true

require 'sequel'

module QuoteMe
  # Module for interfacing with the database
  module Database
    Sequel.extension :migration                     # Load Migrations
    DB = Sequel.sqlite('db/quote_me.db')            # Database Instance
    Sequel::Migrator.run(DB, 'db/migrations')       # Run DB Migrations
    Dir['lib/models/*.rb'].each { |mod| load mod }  # Load Models
  end
end
