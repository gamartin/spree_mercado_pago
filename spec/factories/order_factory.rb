Factory.define(:ppx_order) do |record|
  # associations:
  record.association(:user, :factory => :user)
  record.association(:bill_address, :factory => :address)
  record.association(:shipping_method, :factory => :shipping_method)
  record.ship_address { |ship_address| Factory(:ppx_address, :city => "Chevy Chase", :zipcode => "20815") }
end

Factory.define :ppx_order_with_totals, :parent => :order do |f|
  f.after_create { |order| Factory(:line_item, :order => order) }
end

Factory.define(:order) do |f|
  # associations:
  f.association(:user, :factory => :user)
  f.association(:bill_address, :factory => :address)
  f.completed_at nil
  #f.bill_address_id nil
  #f.ship_address_id nil
  f.email 'foo@example.com'
end

Factory.define :order_with_totals, :parent => :order do |f|
  f.after_create { |order| Factory(:line_item, :order => order) }
end

Factory.define :order_with_inventory_unit_shipped, :parent => :order do |f|
  f.after_create do |order|
    Factory(:inventory_unit, :order => order, :state => 'shipped')
  end
end
