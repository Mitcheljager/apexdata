require "flipper"
require "flipper/adapters/active_record"

Flipper.configure do |config|
  config.default do
    adapter = Flipper::Adapters::Memory.new
    Flipper.new(adapter)
  end
end
