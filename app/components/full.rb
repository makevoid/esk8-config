class Full
  include Inesita::Component

  def initialize
    Timeout.new do
      @conf = @store.configurator if @store
      render!
    end
  end

  def render
    div(class: "container") {
      h5 { text "Full configuration" }

      @conf.config.each do |key, val|
        component ConfigInput.new key: key
      end if @conf
    }
  end
end
