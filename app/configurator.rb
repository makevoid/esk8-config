DEFAULT_CONFIG = "
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<MCConfiguration>
  <l_current_max>70</l_current_max>
  <l_current_min>-70</l_current_min>
</MCConfiguration>
"

class Configurator
  # configurator for VESC Motor configuration (MCConfiguration XML file)

  attr_reader :config

  def initializer(config_raw=DEFAULT_CONFIG) # raw XML config
    @config_raw  = config_raw
    @config      = parse
    @config_core = select_core
  end

  # parse

  def parse!
    Nokogiri::XML config_raw
  end

  LABELS = {
    current_limits: "Current"

    l_current_max:      "Motor max",
    l_current_min:      "Motor min (regen)",
    l_in_current_max:   "Batt max",
    l_in_current_min:   "Batt min (regen)",
    l_abs_current_max:  "Absolute max",

    l_max_erpm:          "Max RPM limit (BLDC)",

    l_battery_cut_start: "Battery cutoff start",
    l_battery_cut_end:   "Battery cutoff end",


    sl_min_erpm:                 "Sensorless min RPM",
    sl_min_erpm_cycle_int_limit: "Integrator limit",
    sl_bemf_coupling_k:          "BEMF coupling",
  }

  CORE_CONFIGS = {
    motor: %i(
      l_current_max
      l_current_min
      l_in_current_max
      l_in_current_min
      l_abs_current_max
    ),
    rpm_limiting: %i(
      l_max_erpm
    ),
    battery: %i(
      l_battery_cut_start
      l_battery_cut_end
    ),
    bldc: %i(
      sl_min_erpm
      sl_min_erpm_cycle_int_limit
      sl_bemf_coupling_k
    ),
  }

  def select_core
    c = CORE_CONFIGS
    {
      motor:        select @config, :motor
      rpm_limiting: select @config, :rpm_limiting
      battery:      select @config, :battery
      bldc:         select @config, :bldc
      # ...
    }
  end

  private

  def select(config, config_key, core: true)
    conf = CORE_CONFIGS
    conf = CONFIGS unless core
    config.select{ |k, v| conf[config_key].include? k },
  end


  public

  # output

  def to_hson

  end

  def to_json
    @config.to_json
  end

  def to_xml
    @config.to_json
  end

  def core
    Object.new
  end

  def core.to_json
    @config_core.to_json
  end
end

# ---

require 'nokogiri'

VESC_CONFIG = File.read File.expand_path "./tmp/test.xml"

config = Configurator.new VESC_CONFIG
# config.to_hson

puts config.to_json
