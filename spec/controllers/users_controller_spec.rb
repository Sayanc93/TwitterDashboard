require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "tests users controller actions" do
    let(:user) { create(:user) }

    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    it "returns http success on edit action" do
      get :edit, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end

    it "recreates hashtag when passed hashtag params" do
      user.hashtags.create(name: '#trump')
      user.hashtags.create(name: '#gameofthrones')

      put :update, params: { id: user.id, hashtags: ['cat', '#dog', '#dog'] }

      expect(user.hashtags.size).to eq(2)

      tags = user.hashtags.map(&:name)

      expect(tags.count { |tag| tag == '#dog'}).to eq(1)
      expect(tags.include?("#cat")).to be_truthy
      expect(tags.include?("#dog")).to be_truthy
    end
  end
end
