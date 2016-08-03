DEFAULT_CONFIG_XML = "
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<MCConfiguration>
  <l_current_max>70</l_current_max>
  <l_current_min>-70</l_current_min>
</MCConfiguration>
".strip

class Store
  include Inesita::Store

  attr_reader :configurator

  def initialize
    # @configurator = Configurator.new DEFAULT_CONFIG, type: :json
    @configurator = Configurator.new DEFAULT_CONFIG_XML
    @store = @configurator.config

    store = @store.to_n
    if `localStorage.esk8_config`
      #   @store = Hash.new `localStorage.esk8_config_store`
      @store.each do |key, _|
        val = `localStorage["esk8_config_"+key]`
        set key, val.to_i
      end
    end
  end

  def load_xml!(config)
    @configurator = Configurator.new config
    @store = @configurator.config
    puts @store
    #
  end

  def load_json!(config)
    # TODO
      @configurator = Configurator.new config, type: :json
      @store = @configurator.config
    "todo"
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
end
