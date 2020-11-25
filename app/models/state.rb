class State < ApplicationRecord
    has_many :cities
    has_many :users
    has_many :addresses
end
