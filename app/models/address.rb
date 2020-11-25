class Address < ApplicationRecord
  belongs_to :company
  belongs_to :state
  belongs_to :city
end
