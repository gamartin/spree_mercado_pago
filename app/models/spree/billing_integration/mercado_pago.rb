class Spree::BillingIntegration::MercadoPago < BillingIntegration
  preference :client_id, :string	
  preference :client_secret, :string	
  preference :no_shipping, :boolean, :default => false
  preference :currency, :string, :default => 'ARS'
  preference :token_url, :string, :default => 'https://api.mercadolibre.com/oauth/token'
  preference :payment_methods, :hash, :default => {:credit_card => ['visa', 'amex', 'master', 'argencard', 'naranja'], :account_money =>'account_money', :atm =>['banelco','redlink'], :ticket => ['bapropagos','pagofacil','rapipago']}
  
  def provider_class
    ActiveMerchant::Billing::Integrations::MercadoPago
  end

  def payment_information(notification_id)
    begin 
    url = "https://api.mercadolibre.com/collections/notifications/#{notification_id}?access_token=#{self.access_token}"
    resp = RestClient.get(url)
    parsed = JSON.parse(resp)
  
    rescue Exception => e
      puts "Error MercadoPago Payment Notification ID => #{notification_id} | PaymentMethod ID => #{self.id}"
      puts e.message
      Rails.logger.error "Error MercadoPago Payment Notification ID => #{notification_id} | PaymentMethod ID => #{self.id}"
      Rails.logger.error e.message
      return nil
    end
  end
  
  def access_token
    begin
    resp = request_for_access_token
    parsed = JSON.parse(resp)
    parsed['access_token'] || nil
    rescue Exception => e
         puts 'ERROR EN get token ============'
         puts e.message
         return nil
    end
  end

  def request_for_access_token
    RestClient.post(self.preferred_token_url,credentials, token_headers)
  end
  
  def payment_button_url(token, data)
    begin
    resp = request_for_payment_config(token, data)
    formated = JSON.parse(resp)
    formated['init_point'] || nil
    rescue Exception => e
        puts 'ERROR EN CONFIGURE ITEMS ============'
        puts e.message
        return nil
    end 
  end
  
  def request_for_payment_config(token,data)
    RestClient.post( end_point_url(token) , data, :content_type => :json, :accept => :json)
  end
  
  def merge_data(order)
      if order
        data = {
      	'external_reference' => "#{order.number}",
      	'items' => [
      	            {'id' => order.number,
      		'title' => 'Nombre','description' => 'Descripcin','quantity' => 1,'unit_price' => order.total.to_f,'currency_id' => self.preferred_currency,
      		'picture_url' => 'https =>//www.mercadopago.com/org-img/MP3/home/logomp3.gif'
      	}],
         "payer" => {
        		"name" => "#{order.bill_address.firstname}",
        		"surname" => "#{order.bill_address.lastname}",
        		"email" => "#{order.email}"
        	},
      	'back_urls' => {
      		'pending' => "http://127.0.0.1:3000/pending",
      		'success' => "http://127.0.0.1:3000/success"
      	},
      	"payment_methods" => {
      		"included_payment_types" => [{"id" => "credit_card"}, {"id" => "bank_transfer"}, {"id" =>"atm"}, {"id" =>"ticket"}, {"id"=>"debit_card"}],
      		"installments" => 18
      	}
      }.to_json
    else 
        return nil
    end
  end
    
  private
    
  def credentials
    {:grant_type => 'client_credentials', :client_id => self.preferred_client_id,:client_secret => self.preferred_client_secret}
  end  
  
  def token_headers
     {:content_type => 'application/x-www-form-urlencoded', :accept => 'application/json'}
  end
  
  def payment_config_headers
    {:content_type => :json, :accept => :json}
  end
  
  def end_point_url(token)
    "https://api.mercadolibre.com/checkout/preferences?access_token=#{token}"
  end

end
