# frozen_string_literal: true

module QuoteMe
  module Database
    # Class repersenting a record from the server_config table
    class ServerConfig < Sequel::Model(:server_config)
      # Allow us the server the key when creating new records
      unrestrict_primary_key
    end
  end
end
