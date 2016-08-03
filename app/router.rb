class Router
  include Inesita::Router

  def routes
    route '/',     to: Home
    route '/full', to: Full
    route '/raw',  to: Raw
  end
end
