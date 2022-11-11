class Pet < ApplicationRecord
    belongs_to :user 

    has_many :appointments, dependent: :destroy

    validates :pet_type, presence: true 
    validates :breed, presence: true 
    validates :name, presence: true 
end
