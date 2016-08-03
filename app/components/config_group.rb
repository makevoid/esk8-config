class ConfigGroup
  include Inesita::Component

  attr_reader :key

  def initialize(key:)
    @key = key
  end

  def render
    div(class: "config-group") {
      label(for: key) {
        text Configurator::LABELS.fetch(key)
      }

      component ConfigInput.new key: key, label: false
    }
  end
end
