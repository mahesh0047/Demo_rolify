# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :addresses
  has_many :users
end
