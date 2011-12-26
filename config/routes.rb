Rails.application.routes.draw do
  
  get "mercado_pago_notification/receive"
  match "/mercado_pago_no/show" => "mercado_pago#show", :as => :show_me_the_money 
  
  resources :orders do
    resource :checkout, :controller => 'checkout' do
      member do
        get :mercado_pago_payment
      end
    end
  end
  
  # Add your extension routes here
  match '/success' => 'checkout#mercado_pago_success'
  match '/pending' => 'checkout#mercado_pago_pending'
  
end
