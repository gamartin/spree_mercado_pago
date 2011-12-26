class MercadoPagoAccount < ActiveRecord::Base
  has_many :payments, :as => :source
  
end
