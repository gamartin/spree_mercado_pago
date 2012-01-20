require 'spec_helper'

describe MercadoPagoNotificationController do

  describe "POST 'receive'" do
    let(:order) {Factory(:order_with_totals, :state => 'confirm')}
    
    it "receives payment notification" do
      post :receive, {:order_id => order.number}
      response.should be_success
    end
  end

end
