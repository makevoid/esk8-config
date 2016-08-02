# TODO: move list of config keys outside

CONF_KEYS = %w(
pwm_mode
comm_mode
motor_type
sensor_mode
l_current_max
l_current_min
l_in_current_max
l_in_current_min
l_abs_current_max
l_min_erpm
l_max_erpm
l_max_erpm_fbrake
l_max_erpm_fbrake_cc
l_min_vin
l_max_vin
l_battery_cut_start
l_battery_cut_end
l_slow_abs_current
l_rpm_lim_neg_torque
l_temp_fet_start
l_temp_fet_end
l_temp_motor_start
l_temp_motor_end
l_min_duty
l_max_duty
sl_min_erpm
sl_min_erpm_cycle_int_limit
sl_max_fullbreak_current_dir_change
sl_cycle_int_limit
sl_cycle_int_limit_high_fac
sl_cycle_int_rpm_br
sl_bemf_coupling_k
hall_table_0
hall_table_1
hall_table_2
hall_table_3
hall_table_4
hall_table_5
hall_table_6
hall_table_7
hall_sl_erpm
foc_current_kp
foc_current_ki
foc_f_sw
foc_dt_us
foc_encoder_inverted
foc_encoder_offset
foc_encoder_ratio
foc_sensor_mode
foc_pll_kp
foc_pll_ki
foc_motor_l
foc_motor_r
foc_motor_flux_linkage
foc_observer_gain
foc_duty_dowmramp_kp
foc_duty_dowmramp_ki
foc_openloop_rpm
foc_sl_openloop_hyst
foc_sl_openloop_time
foc_sl_d_current_duty
foc_sl_d_current_factor
foc_hall_table_0
foc_hall_table_1
foc_hall_table_2
foc_hall_table_3
foc_hall_table_4
foc_hall_table_5
foc_hall_table_6
foc_hall_table_7
foc_sl_erpm
s_pid_kp
s_pid_ki
s_pid_kd
s_pid_min_rpm
p_pid_kp
p_pid_ki
p_pid_kd
p_pid_ang_div
cc_startup_boost_duty
cc_min_current
cc_gain
cc_ramp_step_max
m_fault_stop_time_ms
m_duty_ramp_step
m_duty_ramp_step_rpm_lim
m_current_backoff_gain
m_encoder_counts
m_sensor_port_mode
)

# XML_TEMPLATE = "
# <?xml version=\"1.0\" encoding=\"UTF-8\"?>
# <MCConfiguration>
# %s
# </MCConfiguration>
# "
XML_TEMPLATE = "
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
%s
"

# DEFAULT_CONFIG = "
# <?xml version=\"1.0\" encoding=\"UTF-8\"?>
# <MCConfiguration>
#   <l_current_max>70</l_current_max>
#   <l_current_min>-70</l_current_min>
# </MCConfiguration>
# "

class Configurator
  # configurator for VESC Motor configuration (MCConfiguration XML file)

  attr_reader :config, :config_raw

  def initialize(conf_raw, type: :xml) # raw XML config
    @type        = type
    @config_raw  = conf_raw
    @config      = parse!
    @config_core = select_core
  end

  # parse

  def parse!
    @type == :xml ? parse_xml : parse_json
  end

  private

  def parse_xml
    conf = {}
    CONF_KEYS.each do |key|
      xres = XMLMotor.get_node_from_content @config_raw, "MCConfiguration.#{key}"
      conf[key] = xres.first
    end
    conf
  end

  def parse_json
    JSON.parse @config_raw
  end

  public


  LABELS = {
    current_limits: "Current",

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
    current_motor: %i(
      l_current_max
      l_current_min
    ),
    current_battery: %i(
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

  def self.core_configs
    CORE_CONFIGS
  end

  def self.core_configs_plain
    confs = []
    CORE_CONFIGS.each do |key, vals|
      confs += vals
    end
    confs
  end

  def select_core
    c = CORE_CONFIGS
    {
      current_motor:   select(@config, :current_motor),
      current_battery: select(@config, :current_battery),
      rpm_limiting:    select(@config, :rpm_limiting),
      battery:         select(@config, :battery),
      bldc:            select(@config, :bldc),
      # ...
    }
  end

  private

  def select(config, config_key, core: true)
    conf = CORE_CONFIGS
    conf = CONFIGS unless core
    config.select{ |k, v| conf[config_key].include? k }
  end


  public

  # output

  # def to_hjson
  #  # TODO
  # end

  def to_hrf
    # human-readable format
    out = ""
    @config.each do |key, val|
      label = hrf_label key, match: :exact
      label = " (#{label})" if label
      out << "#{key}: #{val}#{label}\n"
    end
    out
  end

  def to_hrfl
    # human-readable format [LABELS]
    hrlf_transform @config
  end

  def core_to_hrfl
    conf_core_plain = {}
    self.class.core_configs_plain.each do |key|
      conf_core_plain[key] = @config[key.to_s]
    end
    hrlf_transform conf_core_plain
  end

  def to_json
    @config.to_json
  end

  def to_xml
    # xml_core = XmlSimple.xml_out config_xml, keeproot: true, noescape: true
    xml_core = "FAIL - no xml transform library"
    (XML_TEMPLATE % xml_core).strip
  end

  private

  def humanize(string)
    string = keys_prefixes_remove string
    string.split(/_| /).map do |w|
      unless w.upcase == w
        w.capitalize
      else
        w
      end
    end.join " "
  end

  def keys_prefixes_remove(key)
    key = key.gsub /^(s_|m_)/, ''
    key = key.gsub /^l_/,   "limit - "
    key = key.gsub /^sl_/,  "BLDC - "
    key = key.gsub /^foc_/, "FOC - "
    key = key.gsub /^s_/,   "speed - "
    key = key.gsub /^p_/,   "position - "
    key = key.gsub /^cc_/,  "current control - "
    key
  end

  def hrlf_transform(config)
    out = ""
    out << "#{"-"*52}\n"
    config.each do |key, val|
      label = hrf_label key
      # out << "#{label}: #{val}\n"
      out << "%-42s: #{val}\n" % label
      out << "#{"-"*52}\n"
    end
    out
  end

  def hrf_label(key, match: nil)
    label = LABELS[key.to_sym]
    return label if match == :exact
    label || humanize(key)
  end

  def config_xml
    conf_xml = {}
    @config.each do |key, val|
      conf_xml[key] = { "content" => val }
    end
    # main key
    {
      "MCConfiguration" => conf_xml
    }
  end

  def core_to_json
    @config_core.to_json
  end
end

# ---
# run this file: either import XML and JSON string - get it converted into a Ruby Hash internally and expored via `to_xml`, `to_json`
#
# # #
# require 'xml-motor'
# require 'xmlsimple'
# require 'json'
#
# VESC_CONFIG      = File.read File.expand_path "./tmp/test.xml"
# VESC_CONFIG_JSON = File.read File.expand_path "./tmp/test.json"
#
# config = Configurator.new VESC_CONFIG
# # config = Configurator.new VESC_CONFIG_JSON, type: :json
#
# puts "JSON"
# puts config.to_json
# puts
# puts "XML"
# puts config.to_xml
# puts
# puts "HRF"
# puts config.to_hrf
# puts
# puts "HRFL"
# puts config.to_hrfl
# puts
# puts "HRFL (core configs only)"
# puts config.core_to_hrfl
