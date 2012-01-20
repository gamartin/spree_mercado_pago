class MercadoPagoAccount < ActiveRecord::Base
  has_many :payments, :as => :source
  
  def self.create_from_params(order, params)
    self.create(:surname => order.bill_address.lastname, 
             :name => order.bill_address.lastname, 
             :email => order.email,
             :collection_id => params[:collection_id],
             :collection_status => params[:collection_status]
             )
  end

  
end
