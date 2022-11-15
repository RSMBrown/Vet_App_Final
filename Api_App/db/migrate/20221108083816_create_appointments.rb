class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.belongs_to :pet, foreign_key: true 
      t.string :date 
      t.string :time 

      t.timestamps
    end
  end
end
