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

      if @conf
        div(class: "row") {
          div(class: "col s12 m4") {
            @conf.config.select.with_index{ |c, idx| idx % 3 == 0 }.each { |key, val|
              component ConfigInput.new key: key
            }
          }
          div(class: "col s12 m4") {
            @conf.config.select.with_index{ |c, idx| idx % 3 == 1 }.each { |key, val|
              component ConfigInput.new key: key
            }
          }
          div(class: "col s12 m4") {
            @conf.config.select.with_index{ |c, idx| idx % 3 == 2 }.each { |key, val|
              component ConfigInput.new key: key
            }
          }
        }
      end
    }
  end
end
