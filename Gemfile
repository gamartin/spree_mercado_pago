source 'http://rubygems.org'

gemspec
gem 'delayed_job_active_record'

group :test, :development do
  gem 'rspec-rails'
  gem 'spree_auth', '0.70.1'
  gem 'spree_core', '0.70.1'
  gem 'spree_sample', '0.70.1'
  gem 'sqlite3'
  gem 'json'
  gem 'rest-client'


end

group :test do
  gem "factory_girl"
  gem "capybara"
  gem 'turn', :require => false
  gem 'launchy'
  gem 'fakeweb'
  gem 'database_cleaner'
  gem 'json_spec'

end


if RUBY_VERSION < "1.9"
  gem "ruby-debug"
else
  gem "ruby-debug19"
end


