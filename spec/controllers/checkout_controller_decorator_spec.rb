require 'spec_helper'

describe CheckoutController do

  describe "GET 'pending'" do
    before(:each) do
      @p_m_attrs = Factory.attributes_for(:mercado_pago_payment_method)
      @payment_method = Spree::BillingIntegration::MercadoPago.create!(@p_m_attrs)
      @address = Factory.build(:address)
      @order_attrs = Factory.attributes_for(:order)
      @order = Order.create!(@order_attrs)
      @order.bill_address=@address
      @order.save
    	
    end
    
    it "process payment notification from MercadoPago with pending status" do
       get :pending, data('status')
       
    end
    
    def data(status)
      {:collection_id => '1234321', :collection_status => status, :external_reference => 'R32343q23', :preference_id => '123'}
    end
  end
  

end
