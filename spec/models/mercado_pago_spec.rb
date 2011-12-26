require 'spec_helper'
describe Spree::BillingIntegration::MercadoPago do
  
  before(:each) do
    @p_m_attrs = Factory.attributes_for(:mercado_pago_payment_method)
    @payment_method = Spree::BillingIntegration::MercadoPago.create!(@p_m_attrs)
    @address = Factory.build(:address)
    @order_attrs = Factory.attributes_for(:order)
    @order = Order.create!(@order_attrs)
    @order.bill_address=@address
    @order.save
  end
  
  it "should retrieve a new access token from MercadoPago" do
     response = @payment_method.request_for_access_token
     response.should have_json_type(String).at_path("access_token")
     response.should have_json_type(String).at_path("token_type")
     response.should have_json_type(Integer).at_path("expires_in")
     response.should have_json_type(String).at_path("scope")
     response.should have_json_type(String).at_path("refresh_token")
  end
  
  it "should return a newly requested access token" do 
     token = @payment_method.access_token
     token.should be_an_instance_of(String)
     token.should_not be_empty
     
  end
  
  it "should post payment process configuration to MercadoPago" do
     token = @payment_method.access_token
     data  = @payment_method.merge_data(@order)
     response = @payment_method.request_for_payment_config(token, data)
     response.should have_json_path("external_reference")

     response.should have_json_path("items/0/id")
     response.should have_json_path("items/0/title")
     response.should have_json_path("items/0/description")
     response.should have_json_path("items/0/quantity")
     response.should have_json_path("items/0/unit_price")
     response.should have_json_path("items/0/currency_id")
     response.should have_json_path("items/0/picture_url")
     
     response.should have_json_path("date_created")
     response.should have_json_path("subscription_plan_id")
     response.should have_json_path("id") #identificador_de_la_preferencia
     response.should have_json_path("collector_id")#tu_identificador_como_vendedor
     response.should have_json_path("init_point")
     response.should have_json_path("expires")
     response.should have_json_path("expiration_date_to")
     response.should have_json_path("expiration_date_from")
     

     
     response.should have_json_path("payer")
     response.should have_json_path("payer/email")
     response.should have_json_path("payer/name")
     response.should have_json_path("payer/surname")

     response.should have_json_path("back_urls")
     response.should have_json_path("back_urls/failure")
     response.should have_json_path("back_urls/pending")
     response.should have_json_path("back_urls/success")
     
     response.should have_json_path("payment_methods")


    
  end
  
  it "should get 'init_point' url for MercadoPago payment button" do
     token = @payment_method.access_token
     data  = @payment_method.merge_data(@order)
     init_point = @payment_method.payment_button_url(token,data)
     token.should be_an_instance_of(String)
     token.should_not be_empty
  end

end