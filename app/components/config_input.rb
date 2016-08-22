class ConfigInput
  include Inesita::Component
  include TextHelpers

  attr_reader :key

  def initialize(key:, label: true)
    @key   = key
    @label = label

    # change debounced for keyup
    #
    change_base = -> (e)  {
      key = e.target.name
      val = e.target.value
      # `console.log(key, val)`
      @store.set key, val.to_f
    }.to_n

    Timeout.new 500 do
      @change_debounced = `window._.debounce(change_base, 800)`
    end
  end

  def change(e)
    key = e.target.name
    val = e.target.value
    # `console.log(key, val)`
    @store.set key, val.to_f
    render!
  end

  def change_debounced(e)
    change_deb = @change_debounced.to_n
    `change_deb(e)`
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
