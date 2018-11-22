require 'rails_helper'

RSpec.describe Rating, type: :model do
  # Association test
  # ensure an item record belongs to a single todo record
  it { should belong_to(:post) }

  # Validation test
  it "is valid with valid attribute" do
  	user = create(:user)
  	post = create(:post, user: user)
    expect(Rating.new(value: 5, post: post)).to be_valid
  end

  it "is not valid with out of range attribute" do
    user = create(:user)
  	post = create(:post, user: user)
    expect(Rating.new(value: 6, post: post)).to_not be_valid
  end

  it "is not valid with nil attribute" do
    user = create(:user)
  	post = create(:post, user: user)
    expect(Rating.new(value: nil, post: post)).to_not be_valid
  end
end
