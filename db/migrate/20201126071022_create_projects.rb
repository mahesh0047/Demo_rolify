class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.date :start_date
      t.references :language, null: false, foreign_key: true

      t.timestamps
    end
  end
end
