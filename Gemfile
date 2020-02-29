source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.2"
gem "pg"
gem "puma", "~> 3.12"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "inline_svg"
gem "net-ping"

gem "bcrypt", :require => "bcrypt"
gem "high_voltage", "~> 3.0.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
  gem "sqlite3", "1.4.1"
end

group :development do
  gem "win32-security"
  gem "web-console", ">= 3.3.0"
end

group :production do
  gem "autoprefixer-rails"
  gem "heroku-deflater"
  gem "scout_apm"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
