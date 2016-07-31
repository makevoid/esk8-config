class Store
  include Inesita::Store

  def initialize
    @configurator = Configurator.new
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
