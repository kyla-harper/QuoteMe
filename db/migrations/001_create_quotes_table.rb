# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :quotes do
      primary_key :id
      string :server_id, size: 20, null: false
      string :name, size: 32, null: false
      string :added_by, size: 32, null: false
      string :body, size: 1900, null: false
    end
  end
end
