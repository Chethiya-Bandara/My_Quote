class CreatePhilosophers < ActiveRecord::Migration[8.0]
  def change
    create_table :philosophers do |t|
      t.string :fname, null: true
      t.string :lname, null: true
      t.date :birth_year, null: true
      t.date :death_year, null: true
      t.text :biography, null: true

      t.timestamps
    end
  end
end
