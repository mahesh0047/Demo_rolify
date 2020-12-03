# frozen_string_literal: true

class City < ApplicationRecord
  belongs_to :state
  has_many :users
  has_many :addresses
end
