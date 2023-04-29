require 'rails_helper'

RSpec.describe CategoryExpense, type: :model do
  describe 'associations' do
    it { should belong_to(:category) }
    it { should belong_to(:expense) }
  end
end
