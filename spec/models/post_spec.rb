require 'rails_helper'

RSpec.describe Post, type: :model do
  # Association test
  # ensure an item record belongs to a single todo record
  it { should belong_to(:user) }

  # Validation tests
  it "is valid with valid attribute" do
  	user = create(:user)
    expect(Post.new(title: "title1", body: "Bodybody", user: user)).to be_valid
  end

  it "is not valid with "" attribute" do
  	user = create(:user)
    expect(Post.new(title: "", body: "Bodybody", user: user)).to_not be_valid
  end
end
