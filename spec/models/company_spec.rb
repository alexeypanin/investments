require "rails_helper"

RSpec.describe Company, :type => :model do
  it { should have_many(:credits) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
