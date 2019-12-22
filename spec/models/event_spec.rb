require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should validate_presence_of(:performer) }
  it { should validate_presence_of(:when) }
  it { should validate_presence_of(:content) }
end
