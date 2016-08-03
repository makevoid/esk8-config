class ConfigGroup
  include Inesita::Component

  attr_reader :key

  def initialize(key:)
    @key = key
  end

  def change(e)
    key = e.target.name
    val = e.target.value
    `console.log(key, val)`
    @store.set key, val.to_i
    # Calc.calc! @store
    # Configurator.new ...
    render!
  end

  def render
    div(class: "config-group") {
      label(for: key) {
        text Configurator::LABELS.fetch(key)
      }

      input(name: key, value: @store.get(key), onkeyup: method(:change), type: "text", id: key, class: key)
    }
  end
end
