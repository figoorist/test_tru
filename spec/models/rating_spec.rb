require 'rails_helper'

RSpec.describe Rating, type: :model do
  # Association test
  # ensure an item record belongs to a single todo record
  it { should belong_to(:post) }
  # Validation test
  # ensure column title is present before saving
  it { should validate_presence_of(:value) }
end
