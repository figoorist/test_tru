require 'rails_helper'

RSpec.describe Post, type: :model do
  # Association test
  # ensure an item record belongs to a single todo record
  it { should belong_to(:user) }
  # Validation test
  # ensure column title is present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:author_ip) }
end