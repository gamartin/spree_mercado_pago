# encoding: utf-8
require 'spec_helper'

describe "ShoppingCarts" do
  
  describe "filling shopping cart" do
    
    before(:each) do 
      @payment_method = Factory.create(:mercado_pago_payment_method)
    end
    
    after(:each) do
      PaymentMethod.find(@payment_method.id).destroy
    end
    
    def fill_bill_address
      fill_in('order_bill_address_attributes_firstname', :with => 'Ñam fi')
      fill_in('order_bill_address_attributes_lastname', :with => 'Frufi')
      fill_in('order_bill_address_attributes_address1', :with => 'Fali fru fi')
      fill_in('order_bill_address_attributes_city', :with => 'Ñam fi fru!')
      select('Alabama', :from => 'order_bill_address_attributes_state_id')
      #select_second_option('order_bill_address_attributes_state')
      fill_in('order_bill_address_attributes_zipcode', :with => '123123123')
      select('United States', :from => 'order_bill_address_attributes_country_id')
      fill_in('order_bill_address_attributes_phone', :with => '123123123')
    end
    
    def fill_ship_address
      fill_in('order_ship_address_attributes_firstname', :with => 'Ñam fi')
      fill_in('order_ship_address_attributes_lastname', :with => 'Frufi')
      fill_in('order_ship_address_attributes_address1', :with => 'Fali fru fi')
      fill_in('order_ship_address_attributes_city', :with => 'Ñam fi fru!')
      select('Alabama', :from => 'order_ship_address_attributes_state_id')
      #select_second_option('order_bill_address_attributes_state')
      fill_in('order_ship_address_attributes_zipcode', :with => '123123123')
      select('United States', :from => 'order_ship_address_attributes_country_id')
      fill_in('order_ship_address_attributes_phone', :with => '123123123')
    end
    
    it "should add an item to cart and proceed to checkout", :js => true do
            
      visit(root_path)
      click_link('Ruby on Rails Jr. Spaghetti')
      click_button('add-to-cart-button')
      click_link('checkout-link')
      current_path.should == '/checkout/registration'
      fill_in('order_email', :with => 'pomelocuidadoconelrock333@hotmail.com')
      click_button('Continue')
      
      fill_bill_address
      
      fill_ship_address
      
      click_button('Save and Continue')
      page.should have_content('UPS')
      
      click_button('Save and Continue')
      page.should have_content('Mercado Pago')
      page.should have_content('Payment Information')
      
      choose('Mercado Pago')
      click_button('Save and Continue')
      save_and_open_page
      
    end
  end
end

