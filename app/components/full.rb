class Full
  include Inesita::Component

  def initialize
    Timeout.new do
      @conf = @store.configurator if @store
      render!
    end

    @groups = %i(main limits bldc_sensorless bldc_sensors foc pid_control current_control misc)

    # default state
    # TODO: need toggler ui elements
    @groups_active = {
      main: true,
      limits: true,
      bldc_sensorless: true,
      bldc_sensors: false,
      foc:  false,
      pid_control: false,
      current_control: true,
      misc: false,
    }

    # all on
    @groups_active = {
      main: true,
      limits: true,
      bldc_sensorless: true,
      bldc_sensors: true,
      foc:  true,
      pid_control: true,
      current_control: true,
      misc: true,
    }
  end

  def config(conf, &block)
    if @groups_active.fetch conf
      block.call
      div(class: "s-20")
    end
  end

  def render
    div(class: "container") {
      h6 { text "This is the full VESC configuration, divided by section:" }

      if @conf
        # groups = %i(main limits bldc_sensorless bldc_sensors foc pid_control current_control misc)
        gconf = CONF_KEYS_GROUPS

        # @conf.config.select.with_index{ |c, idx| idx % 3 == 0 }.each { |key, val|

        div(class: "row") {
          div(class: "col s12 m4") {

            config(:main) {
              h5 { text "Main"}
              @conf.config.select{|k,v| gconf[:main].include? k }.each { |key, val|
                component ConfigInput.new key: key
              }
            }

            config(:limits) {
              h5 { text "Limits"}
              @conf.config.select{|k,v| gconf[:limits].include? k }.each { |key, val|
                component ConfigInput.new key: key
              }
            }

            config(:current_control) {
              h5 { text "Current control"}
              @conf.config.select{|k,v| gconf[:current_control].include? k }.each { |key, val|
                component ConfigInput.new key: key
              }
            }
          }

          div(class: "col s12 m4") {
            config(:bldc_sensorless) {
              h5 { text "BLDC (sensorless)"}
              @conf.config.select{|k,v| gconf[:bldc_sensorless].include? k }.each { |key, val|
                component ConfigInput.new key: key
              }
            }
           config(:bldc_sensors) {
              h5 { text "BLDC (w/ hall sensors)"}
              @conf.config.select{|k,v| gconf[:bldc_sensors].include? k }.each { |key, val|
                component ConfigInput.new key: key
              }
           }
           config(:pid_control) {
              h5 { text "PID control"}
              @conf.config.select{|k,v| gconf[:pid_control].include? k }.each { |key, val|
                component ConfigInput.new key: key
              }
           }
           config(:misc) {
              h5 { text "Misc"}
              @conf.config.select{|k,v| gconf[:misc].include? k }.each { |key, val|
                component ConfigInput.new key: key
              }
           }
          }

          div(class: "col s12 m4") {
            config(:foc) {
             h5 { text "FOC"}
             @conf.config.select{|k,v| gconf[:foc].include? k }.each { |key, val|
               component ConfigInput.new key: key
             }
           }
         }
         
       }
      end
    }
  end
end
