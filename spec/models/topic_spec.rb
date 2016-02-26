require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:sponsored_post) { SponsoredPost.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }

  it { is_expected.to have_many(:sponsored_post) }
  it { is_expected.to have_many(:labelings) }
  it { is_expected.to have_many(:labels).through(:labelings) }
  

  describe "attributes" do
    it "responds to name" do
        expect(topic).to respond_to(:name)
    end

    it "responds to description" do
      expect(topic).to respond_to(:description)
    end

    it "responds to public" do
      expect(topic.public).to be(true)
    end
  end
end
