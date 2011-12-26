require 'spec_helper'

describe MercadoPagoNotificationController do

  describe "POST 'process'" do
    it "receives payment notification" do
      post 'receive', :collection_id => '74144112'
      mercado_pago_account = MercadoPagoAccount.find_by_collection_id(params[:collection_id])
      payment = mercado_pago_account.payment
    end
  end

end
