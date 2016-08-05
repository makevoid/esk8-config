class ConfigInput
  include Inesita::Component
  include TextHelpers

  attr_reader :key

  def initialize(key:, label: true)
    @key   = key
    @label = label
  end

  def change(e)
    key = e.target.name
    val = e.target.value
    # `console.log(key, val)`
    @store.set key, val.to_f
    render!
  end

  def change_debounced(e)
    key = e.target.name
    val = e.target.value
    # `console.log(key, val)`
    @store.set key, val.to_f
    render!
  end

  def render
    if @label
      label(for: key) {
        text humanize key
      }
    end

    input(name: key, value: @store.get(key), onchange: method(:change), onkeyup: method(:change_debounced), type: "text", id: key, class: key)
  end
end
