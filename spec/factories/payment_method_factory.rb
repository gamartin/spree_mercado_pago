Factory.define :mercado_pago_payment_method, :class => Spree::BillingIntegration::MercadoPago do |f|

  f.name 'Mercado Pago'
  f.active true
  f.preferred_client_id '3232'
  f.preferred_client_secret 'yjabDP6vFPkStY8Yc6wPnBTYljpHl2xa'
  
  f.environment 'test'
  #f.display_on :front_end
end

