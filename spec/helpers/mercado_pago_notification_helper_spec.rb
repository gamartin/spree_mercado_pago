require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the MercadoPagoNotificationHelper. For example:
#
# describe MercadoPagoNotificationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
=begin
describe MercadoPagoNotificationHelper do
  it "recibe notificaciones de pago" do
    FakeWeb.allow_net_connect = false
    FakeWeb.register_uri('http://github.com/api/v1/json/defunkt', :response => File.join(File.dirname(__FILE__), 'fixtures', 'user.json'))
    
  end
end
=end
