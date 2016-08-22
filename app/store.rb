# DEFAULT_CONFIG_XML = "
# <?xml version=\"1.0\" encoding=\"UTF-8\"?>
# <MCConfiguration>
#   <l_current_max>70</l_current_max>
#   <l_current_min>-70</l_current_min>
# </MCConfiguration>
# ".strip

class Store
  include Inesita::Store

  attr_reader :configurator

  attr_reader :status # writer (status=) is defined manually to add loagging

  attr_accessor :xml_blob
  attr_accessor :previous_hash

  def initialize
    @previous_hash = ""
    @configurator = Configurator.new Configurator::DEFAULT_CONFIG_JSON, type: :json
    # @configurator = Configurator.new DEFAULT_CONFIG_XML
    @store = @configurator.config

    store = @store.to_n
    if `localStorage.esk8_config` && location_hash_blank?
      #   @store = Hash.new `localStorage.esk8_config_store`
      @store.each do |key, _|
        val = `localStorage["esk8_config_"+key]`
        set key, val.to_f
      end
    end
  end

  def load_xml!(config)
    @configurator = Configurator.new config
    @store = @configurator.config
  end

  def load_json!(config)
    config = config.strip
    config = $$.window.decodeURIComponent(config) if config[0] == "%" ||  config[1] == "%"
    @configurator = Configurator.new config, type: :json
    @store = @configurator.config
  end

  def set(key, value)
    @store[key] = value
  end

  def get(key)
    @store[key]
  end

  def save!
    @store.each do |key, val|
      `localStorage["esk8_config_"+key] = val`
    end
    `localStorage.esk8_config = true`
  end

  # attr_writer :status
  def status=(status)
    puts "new status: :#{status}"
    @status = status
  end

  private

  def location_hash_blank?
    hash = $$.location.hash
    hash = hash[1..-1]
    !hash || hash == ""
  end
end
