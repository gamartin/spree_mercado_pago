
Factory.define(:order) do |f|
   f.user_id 1057526573
   f.number  'R116023470'
   f.item_total 13.99
   f.total      18.99
   f.state    'confirm'
   f.adjustment_total 5
   f.credit_total 0.0
   f.payment_total 0
   f.payment_state 'balance_due'
   f.email 'me@mailor.com'
end