class Appointment < ApplicationRecord
    belongs_to :pet

    validates :date, presence: true  
    validates :time, presence: true 
end
