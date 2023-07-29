
require "rails_helper"

RSpec.describe Transaction, type: :model do
  it { should belong_to(:invoice) }
  it { should define_enum_for(:result).with_values(success: 1, failed: 0) }
end