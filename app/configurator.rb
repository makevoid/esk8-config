require 'lib/xmlparser'
require 'lib/configurator/constants'

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
    config_raw = @config_raw.to_n
    xmlp = XMLParser.new config_raw
    CONF_KEYS.each do |key|
      res = xmlp.get "/MCConfiguration/#{key}"
      conf[key] = res
    end
    conf
  end

  def parse_json
    JSON.parse @config_raw
  end

  public


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

  def to_json_fmt
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
    out += "#{"-"*52}\n"
    config.each do |key, val|
      label = hrf_label key
      # out << "#{label}: #{val}\n"
      out += "%-42s: #{val}\n" % label
      out += "#{"-"*52}\n"
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
