require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  describe "tests dashboard behavior" do
    let(:user) { create(:user) }

    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    context "it tests successful rendering of index page" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context "it tests initial hashtag submission" do
      it "parses, santizes and creates unique associated hashtags for a user" do
        post :create, params: { hashtags: ['cat', '#dog', '#dog'] }
        expect(user.hashtags.size).to eq(2)

        tags = user.hashtags.map(&:name)

        expect(tags.count { |tag| tag == '#dog'}).to eq(1)
        expect(tags.include?("#cat")).to be_truthy
        expect(tags.include?("#dog")).to be_truthy
      end

      it "tests creation of tracking job when start button is pushed" do
        ActiveJob::Base.queue_adapter = :test
        expect {
          post :initiate_battle
        }.to have_enqueued_job.with(user.id).on_queue("default")
      end

      it "tests updation of user's connection attribute when termination button is pushed" do
        user.update_attributes(connected: true)
        get :terminate_battle
        expect(user.connected).to be_falsy
      end

      it "tests reset counter action" do
        user.hashtags.create(name: "#cat", count: 123)
        user.hashtags.create(name: "#dog", count: 543)
        get :reset_counters
        counters = user.hashtags.pluck(:count)
        expect(counters.all? {|counter| counter == 0 }).to be_truthy
      end
    end
  end

end
