module ContentHelper
  def assault_rifles
    YAML.load(File.read(Rails.root.join("config/content", "assault_rifles.yml")))
  end
end
