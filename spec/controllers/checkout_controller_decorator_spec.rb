require 'spec_helper'

describe CheckoutController do
  #let(:order) { Factory(:order_with_totals, :state => "confirm") }
  #let(:order_total) { (order.total * 100).to_i }
  #let(:order) {Factory(:order_with_totals, :state => 'confirm')}
  #let(:order) { mock_model(Order) }
  


  before do
    Spree::Auth::Config.set(:registration_step => false)
    @order =  Factory(:order, :state => 'confirm') 
    @user  = Factory(:user) 
    @order.stub :checkout_allowed? => true, :user => @user, :new_record? => false
    @order.stub :payment_method => Factory(:payment_method)
    @order.payments.create!(:source_type => 'MercadoPagoAccount').started_processing! 
    @mercado_pago_account = Factory(:mercado_pago_account)
    controller.stub :current_order => @order
    controller.stub :current_user => @order.user
  end
  
  describe "GET 'mercado_pago_pending'" do

    it "receives payment notification from MercadoPago with pending state" do
       get :mercado_pago_pending, :collection_id => '1234321', :collection_status => 'pending', :external_reference => @order.number, :preference_id => '123'
       @order.state == 'complete'
       response.should be_success
    end
    
    it "receives payment notification from MercadoPago with approved state" do
       get :mercado_pago_pending, :collection_id => '1234321', :collection_status => 'approved', :external_reference => @order.number, :preference_id => '123'
       @order.state == 'complete'
       response.should be_success
    end
    
    it "receives payment notification from MercadoPago with in_process state" do
       get :mercado_pago_pending, :collection_id => '1234321', :collection_status => 'in_process', :external_reference => @order.number, :preference_id => '123'
       @order.state == 'complete'
       response.should be_success
    end
    
    it "receives payment notification from MercadoPago with rejected state" do
       get :mercado_pago_pending, :collection_id => '1234321', :collection_status => 'rejected', :external_reference => @order.number, :preference_id => '123'
       @order.state == 'complete'
       response.should be_success
    end

  end
  

end
