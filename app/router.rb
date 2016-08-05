require 'components/clear_localstorage'

class Router
  include Inesita::Router

  def routes
    route '/',     to: Home
    route '/full', to: Full
    route '/raw',  to: Raw
    route '/clear_localstorage',  to: ClearLocalStorage
  end
end
