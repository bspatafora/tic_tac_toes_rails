require 'rails_helper'

RSpec.describe GameController, :type => :controller do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      expect(response).to be_success
    end
  end

  describe "GET 'move'" do
    it "returns http success" do
      get 'move'
      expect(response).to be_success
    end
  end

end
