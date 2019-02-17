module ContentHelper
  def assault_rifles
    YAML.load(File.read(Rails.root.join("config/content", "assault_rifles.yml")))
  end

  def sub_machine_guns
    YAML.load(File.read(Rails.root.join("config/content", "sub_machine_guns.yml")))
  end

  def pistols
    YAML.load(File.read(Rails.root.join("config/content", "pistols.yml")))
  end

  def light_machine_guns
    YAML.load(File.read(Rails.root.join("config/content", "light_machine_guns.yml")))
  end

  def shotguns
    YAML.load(File.read(Rails.root.join("config/content", "shotguns.yml")))
  end

  def sniper_rifles
    YAML.load(File.read(Rails.root.join("config/content", "sniper_rifles.yml")))
  end

  def grenades
    YAML.load(File.read(Rails.root.join("config/content", "grenades.yml")))
  end

  def consumables
    YAML.load(File.read(Rails.root.join("config/content", "consumables.yml")))
  end

  def equipment
    YAML.load(File.read(Rails.root.join("config/content", "equipment.yml")))
  end

  def attachments
    YAML.load(File.read(Rails.root.join("config/content", "attachments.yml")))
  end

  def legends
    YAML.load(File.read(Rails.root.join("config/content", "legends.yml")))
  end

  def legend(name)
    legends.select { |legend| legend["name"] == name }.first
  end

  def badges
    YAML.load(File.read(Rails.root.join("config/content", "universal_badges.yml")))
  end

  def weapons
    assault_rifles.concat(sub_machine_guns).concat(pistols).concat(light_machine_guns).concat(shotguns).concat(sniper_rifles)
  end
end
