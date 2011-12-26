Factory.define :state do |f|
  f.name 'Maryland'
  f.abbr 'MD'
  f.country { |country| country.association(:country) }
end
