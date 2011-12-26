source 'http://rubygems.org'
gem 'json'
gem 'rest-client'
gemspec


group :test, :development do
  gem 'rspec-rails'#, '= 2.6.1'
  gem 'spree_auth', '0.70.1'
  gem 'spree_core', '0.70.1'
  gem 'spree_sample', '0.70.1'
  gem 'sqlite3'
  gem 'fakeweb'
  gem 'database_cleaner'
  gem 'json_spec'

end

group :test do
  gem "factory_girl"
  gem "capybara"#, '1.0.1'
  gem "guard-rspec"
  gem 'turn', :require => false
  gem 'launchy'

end




if RUBY_VERSION < "1.9"
  gem "ruby-debug"
else
  gem "ruby-debug19"
end


#gem 'spree_blue_theme', :git => 'git://github.com/spree/spree_blue_sass_theme.git'
