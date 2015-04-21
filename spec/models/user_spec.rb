require 'spec_helper'

describe User do
  let(:user) { Fabricate(:user) }

  describe "validations" do 
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:full_name) }
  end

  describe "Relationships" do 
    it { should have_many(:reviews) }
    it { should have_many(:queue_items) }
    it { should have_many(:relationships) }
    it { should have_many(:followings) }
    it { should have_many(:followers) }
  end

  it "generates a random token when the user is created" do 
    expect(user.token).to be_present
  end
end
