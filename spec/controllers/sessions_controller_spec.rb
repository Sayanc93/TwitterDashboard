require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "tests session behavior" do
    context "it tests successful rendering of index page" do
      before :each do
        @twitter_auth = Faker::Omniauth.twitter
      end
      it "returns http success" do
        OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
                                                :provider => 'twitter',
                                                :uid => @twitter_auth[:uid],
                                                :credentials => @twitter_auth[:credentials],
                                                :info => @twitter_auth[:info] })

        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]

        get :create, params: { provider: 'twitter' }

        expect(response).to have_http_status(:redirect)

        user_created = User.last

        expect(user_created.name).to eq(@twitter_auth[:info][:name])
        expect(user_created.token).to eq(@twitter_auth[:credentials][:token])
        expect(user_created.secret).to eq(@twitter_auth[:credentials][:secret])
      end

      it "tests previously created user is not created again" do
        @twitter_auth = Faker::Omniauth.twitter
        create(:user, uid: @twitter_auth[:uid])

        OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
                                                :provider => 'twitter',
                                                :uid => @twitter_auth[:uid],
                                                :credentials => @twitter_auth[:credentials],
                                                :info => @twitter_auth[:info] })
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]

        expect {
          get :create, params: { provider: 'twitter' }
        }.to_not change { User.count }
      end

      it "tests logging out mechanism" do
        user = create(:user, uid: @twitter_auth[:uid], connected: true)
        request.env['rack.session'][:user_id] = user.id

        delete :destroy

        expect(request.env['rack.session'][:user_id]).to be_nil
        expect(user.reload.connected).to be_falsy
      end
    end
  end
end
