# TODO move these guys in utils.rb

module Timings
  def sec
    1000
  end
end

module Aliases
  def t(*args)
    text *args
  end
end

module Utils
  include Aliases
  include Timings
end

# require 'utils'

# ---

class Status
  include Inesita::Component
  include Utils

  def initialize
    @status_display = "block"
  end

  def hide_status(after:)
    Timeout.new after*sec do
      @status_display = "none"
    end
  end


  def render
    @status_display = "block"

    div(class: "status", style: "display: #{@status_display.to_n};") do
      t @store.status
    end

    hide_status after: 10 # seconds
  end
end
