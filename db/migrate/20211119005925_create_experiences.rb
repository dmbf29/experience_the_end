class CreateExperiences < ActiveRecord::Migration[6.1]
  def change
    create_table :experiences do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.integer :price
      t.string :address

      t.timestamps
    end
  end
end
