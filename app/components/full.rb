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
      h6 { text "This is the full VESC configuration, divided by section:" }

      if @conf
        # groups = %i(main limits bldc_sensorless hall_sensors foc pid_control current_control misc)
        gconf = CONF_KEYS_GROUPS

        # @conf.config.select.with_index{ |c, idx| idx % 3 == 0 }.each { |key, val|

        div(class: "row") {
          div(class: "col s12 m4") {
            h5 { text "Main"}
            @conf.config.select{|k,v| gconf[:main].include? k }.each { |key, val|
              component ConfigInput.new key: key
            }
            div(class: "s-20")

            h5 { text "Limits"}
            @conf.config.select{|k,v| gconf[:limits].include? k }.each { |key, val|
              component ConfigInput.new key: key
            }

            h5 { text "Current control"}
            @conf.config.select{|k,v| gconf[:current_control].include? k }.each { |key, val|
              component ConfigInput.new key: key
            }
            div(class: "s-20")

          }
          div(class: "col s12 m4") {
            h5 { text "BLDC (sensorless)"}
            @conf.config.select{|k,v| gconf[:bldc_sensorless].include? k }.each { |key, val|
              component ConfigInput.new key: key
            }
            div(class: "s-20")

            h5 { text "Sensors"}
            @conf.config.select{|k,v| gconf[:hall_sensors].include? k }.each { |key, val|
              component ConfigInput.new key: key
            }
            div(class: "s-20")

            h5 { text "PID control"}
            @conf.config.select{|k,v| gconf[:hall_sensors].include? k }.each { |key, val|
              component ConfigInput.new key: key
            }
            div(class: "s-20")

            h5 { text "Misc"}
            @conf.config.select{|k,v| gconf[:misc].include? k }.each { |key, val|
              component ConfigInput.new key: key
            }
            div(class: "s-20")

          }
          div(class: "col s12 m4") {
            h5 { text "FOC"}
            @conf.config.select{|k,v| gconf[:foc].include? k }.each { |key, val|
              component ConfigInput.new key: key
            }
            div(class: "s-20")

          }
        }
      end
    }
  end
end
