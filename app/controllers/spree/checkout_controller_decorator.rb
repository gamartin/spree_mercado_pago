module Spree
  CheckoutController.class_eval do
    before_filter :mercado_pago_hook, :only => [:update]
    #respond_override :update => { :html => { :success => lambda { render :partial => "spree/checkout/payment.html.erb" } } }

    def mercado_pago_payment
       payment_method =  PaymentMethod.find(params[:payment_method_id])
       load_order
       
       @token = payment_method.access_token
       @data = payment_method.merge_data(@order)
       @pay_url = payment_method.payment_button_url(@token, @data)
       @order.payments.create!(:source_type => 'MercadoPagoAccount',
         :payment_method_id => params[:payment_method_id])      
    end
    def mercado_pago_success
      load_order

      opts = {}#{ :token => params[:token], :payer_id => params[:PayerID] }.merge all_opts(@order, params[:payment_method_id], 'payment' )
      payment_method = Spree::PaymentMethod.find(params[:payment_method_id]) || Spree::BillingIntegration::MercadoPago.first

 
    end
    
    def mercado_pago_pending
      load_order

      #opts = {}#{ :token => params[:token], :payer_id => params[:PayerID] }.merge all_opts(@order, params[:payment_method_id], 'payment' )
      #payment_method = Spree::PaymentMethod.find(params[:payment_method_id]) || Spree::BillingIntegration::MercadoPago.first
      @payment = Payment.find_by_order_id(@order.id)
      
      if @payment.source_type == 'MercadoPagoAccount'
        payment_method =  Spree::BillingIntegration::MercadoPago.first
      end
      mercado_pago_account = MercadoPagoAccount.create(:surname => @order.bill_address.lastname, :name => @order.bill_address.lastname, :email => @order.email)
      
      if params[:collection_id]
         mercado_pago_account.collection_id = params[:collection_id]
         mercado_pago_account.collection_status = params[:collection_status]
         mercado_pago_account.save
      end
      @payment.source = mercado_pago_account
      @payment.started_processing!
      case params[:collection_status]
      when "approved"  
        @payment.complete!
      when "pending"
        @payment.pending!
      when "in_process"
        @payment.processing!
     when "rejected"
        @payment.failed!
      else
        @payment.pend!
        Rails.logger.error "Respuesta inesperada"
        Rails.logger.error "order => #{@order.id} | #{@order.number}, collection_id =>#{params[:collection_id]} collection_status => #{params[:collection_status]}"
      end
      @payment.save
      until @order.state == "complete"
        if @order.next!
          @order.update!
          state_callback(:after)
        end
      end
    end

    private

    def mercado_pago_hook
     return unless (params[:state] == "payment")
     return unless params[:order][:payments_attributes]
     payment_method = PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])
     if payment_method.kind_of?(Spree::BillingIntegration::MercadoPago) 
       load_order
       #MercadoPagoAccount.create(:email => @order.email, :name => @order.bill_address.firstname, :surname => @order.bill_address.lastname)
       redirect_to(mercado_pago_payment_order_checkout_url(@order, :payment_method_id => payment_method))
     end

    end


 
  

  end
end