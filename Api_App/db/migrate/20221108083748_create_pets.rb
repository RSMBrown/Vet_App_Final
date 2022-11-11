class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.belongs_to :user, foreign_key: true 
      t.string :name 
      t.string :pet_type
      t.string :breed

      t.timestamps
    end
  end
end
