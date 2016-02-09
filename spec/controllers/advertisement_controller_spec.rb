require 'rails_helper'
include RandomData

RSpec.describe AdvertisementController, type: :controller do
  let (:my_ad) do
    Advertisment.create(
      id: 1,
      title: RandomData.random_sentence,
      copy:  RandomData.random_paragraph,
      price: 99
    )
  end
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [my_ad] to @advertisement" do
      get :index
      expect(assigns(:advertisement)).to eq([my_ad])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      get :show, {id: my_ad.id}
      expect(response).to render_template :show
    end
    it "assigns my_ad to @advertisement" do
        get :show, {id: my_ad.id}
        expect(assigns(:advertisement)).to eq(my_ad)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "renders the #new view" do
        get :new
        expect(response).to render_template :new
    end
    it "instatiates @advertisement" do
      get :new
      expect(assigns(:post)).not_to be_nil
    end
  end

  descrive "Ad create" do
    it "increases the number of Ad by 1" do
      expect{post :create, advertisement: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Advertisement, :count).by(1)
    end
    it "assigns the new ad to @advertisement" do
        advertisement :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(assigns(:advertisement)).to eq Advertisement.last
    end
    it "redirects to the new advertisement" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to Advertisement.last
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

end
