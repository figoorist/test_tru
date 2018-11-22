require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should have_many(:posts).dependent(:destroy) }

  # Validation tests
  it "is valid with valid attribute" do
    expect(User.new(login: "New")).to be_valid
  end

  it "is not valid with nil attribute" do
    expect(User.new(login: nil)).to_not be_valid
  end
end
