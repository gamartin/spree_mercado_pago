class MercadoPagoNotificationController < ApplicationController
  
  def receive
     if params[:topic]=='payment'
      notification = MercadoPagoNotification.new(params[:id])
      Delayed::Job.enqueue notification, :queue => 'mercado_pago_notifications'
      render :nothing => true
     end
  end

end
