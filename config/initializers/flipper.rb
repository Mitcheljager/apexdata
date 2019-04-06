require "flipper"

Flipper.configure do |config|
  config.default do
    adapter = Flipper::Adapters::Memory.new
    Flipper.new(adapter)
  end
end
