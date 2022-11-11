require 'rails_helper'

RSpec.describe Appointment, type: :model do 
    it { should belong_to(:pet) }

    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:time) }
end 