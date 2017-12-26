source 'https://rubygems.org'
ruby '2.3.3'

gem 'cocoapods', '~> 1.4.0.beta.2'
gem 'bundler', '~> 1.15'
gem "xcode-install"

gem 'rubyzip', '>= 1.0.0'
gem 'zip-zip'

gem 'earlgrey'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval(File.read(plugins_path), binding) if File.exist?(plugins_path)
