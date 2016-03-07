require 'rails_helper'

RSpec.describe Topic, type: :model do

  let(:topic) { create(:topic) }

  let(:post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  it { is_expected.to have_many(:posts) }
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
      expect(topic).to respond_to(:public)
    end

    it "is public by default" do
      expect(topic.public).to be(true)
    end
  end

  describe "scopes" do
    before do
      @public_topic = Topic.create
      @private_topic = Topic.create(public: false)
    end

    describe "visible_to(user)" do
      it "returns all topics if the user is present" do
        user = true
        expect(Topic.visible_to(user)).to eq(Topic.all)
      end

      it "returns only public topics if user is nil" do
        user = false
        expect(Topic.visible_to(user)).to eq(Topic.publicly_viewable)
      end

      describe 'publicly_viewable' do
        it 'returns all public topics' do
          expect(Topic.publicly_viewable).to eq( [@public_topic] )
        end
      end

      describe 'privately_viewable' do
        it 'returns all private topics' do
          expect(Topic.privately_viewable).to eq( [@private_topic] )
        end
      end
    end
  end
end
