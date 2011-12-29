module Spree
  CheckoutController.class_eval do
    before_filter :mercado_pago_hook, :only => [:update]

    def mercado_pago_payment
       payment_method =  PaymentMethod.find(params[:payment_method_id])
       load_order
       
       @token = payment_method.access_token
       @data = payment_method.merge_data(@order)
       @pay_url = payment_method.payment_button_url(@token, @data)
       unless @pay_url
         gateway_error I18n.t(:unable_to_connect_to_gateway)
         redirect_to edit_order_url(@order)
       end
       @order.payments.create!(:source_type => 'MercadoPagoAccount', :payment_method_id => params[:payment_method_id]).started_processing! 
    end
    
    def mercado_pago_success
      load_order

 
    end
    
    def mercado_pago_pending
      if params[:collection_status] == 'pending'
        load_order
        payment_method =  @order.payment_method
        mercado_pago_account = MercadoPagoAccount.new_from_params(@order, params)
        mercado_pago_account.save
        @order.payment.source = mercado_pago_account
        @order.payment.pend!
        until @order.state == "confirm"
            if @order.next!
              @order.update!
            end
        end
        @order.save
      else
        Rails.logger.error "Respuesta inesperada"
        Rails.logger.error "order => #{@order.id} | #{@order.number}, collection_id =>#{params[:collection_id]} collection_status => #{params[:collection_status]}"
      end
    
    end

    private

    def mercado_pago_hook
     return unless (params[:state] == "payment")
     return unless params[:order][:payments_attributes]
     payment_method = PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])
     if payment_method.kind_of?(Spree::BillingIntegration::MercadoPago) 
       load_order
       redirect_to(mercado_pago_payment_order_checkout_url(@order, :payment_method_id => payment_method))
     end

    end
    
    def gateway_error(response)
      if response.is_a? ActiveMerchant::Billing::Response
        text = response.params['message'] ||
               response.params['response_reason_text'] ||
               response.message
      else
        text = response.to_s
      end

      msg = "#{I18n.t('gateway_error')}: #{text}"
      logger.error(msg)
      flash[:error] = msg
    end



 
  

  end
end