module ContentHelper
  def assault_rifles
    items = YAML.load(File.read(Rails.root.join("config/content", "assault_rifles.yml")))
    calculate_extra_values(items)
  end

  def sub_machine_guns
    items = YAML.load(File.read(Rails.root.join("config/content", "sub_machine_guns.yml")))
    calculate_extra_values(items)
  end

  def pistols
    items = YAML.load(File.read(Rails.root.join("config/content", "pistols.yml")))
    calculate_extra_values(items)
  end

  def light_machine_guns
    items = YAML.load(File.read(Rails.root.join("config/content", "light_machine_guns.yml")))
    calculate_extra_values(items)
  end

  def shotguns
    items = YAML.load(File.read(Rails.root.join("config/content", "shotguns.yml")))
    calculate_extra_values(items)
  end

  def sniper_rifles
    items = YAML.load(File.read(Rails.root.join("config/content", "sniper_rifles.yml")))
    calculate_extra_values(items)
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
    legends.select { |legend| legend["name"].parameterize.downcase == name.parameterize.downcase }.first
  end

  def badges
    YAML.load(File.read(Rails.root.join("config/content", "universal_badges.yml")))
  end

  def tierlist
    YAML.load(File.read(Rails.root.join("config/content", "tierlist.yml")))
  end

  def weapons
    assault_rifles.concat(sub_machine_guns).concat(pistols).concat(light_machine_guns).concat(shotguns).concat(sniper_rifles)
  end

  def calculate_extra_values(array)
    array.each do |item|
      rate_of_fire = item["rate_of_fire"] < 60 ? 1 : item["rate_of_fire"] / 60
      dps_value = "%2g" % ("%.1f" % (item["damage"] * rate_of_fire))
      dps_value = dps_value.to_i * item["damage_modifier"] if item["damage_modifier"]

      item["damage_per_second"] = dps_value.to_i

      damage = item["ammo_capacity"] * item["damage"]
      if item["damage_modifier"]
        damage = damage * item["damage_modifier"]
      end

      item["damage_per_magazine"] = damage
    end
  end
end
