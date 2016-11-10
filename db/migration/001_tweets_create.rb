# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:tweets) do
      primary_key :id
      String :tweet_id
      String :create_time
      String :text
    end
  end
end
