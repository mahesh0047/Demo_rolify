class Company < ApplicationRecord
    has_many :addresses
    has_many :users
end
