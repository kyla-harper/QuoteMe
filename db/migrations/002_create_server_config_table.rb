# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :server_config do
      String :server_id, index: true, primary_key: true, size: 20
      FalseClass :import_nadeko, default: false, null: false
    end
  end
end
