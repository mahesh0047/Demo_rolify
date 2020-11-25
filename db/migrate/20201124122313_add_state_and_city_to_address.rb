class AddStateAndCityToAddress < ActiveRecord::Migration[6.0]
  def change
    add_reference :addresses, :state, null: true, foreign_key: true
    add_reference :addresses, :city, null: true, foreign_key: true
  end
end
