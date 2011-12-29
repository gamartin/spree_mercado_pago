Rails.application.routes.draw do

  resources :orders do
    resource :checkout, :controller => 'checkout' do
      member do
        get :mercado_pago_payment
      end
    end
  end
  
  # Add your extension routes here
  match '/success' => 'checkout#mercado_pago_success'
  match '/pending/:collection_id/:collection_status/:external_reference/:preference_id' => 'checkout#mercado_pago_pending'
  
end
