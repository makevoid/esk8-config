class Layout
  include Inesita::Layout

  def render
    div class: 'outer-container' do
      component NavBar
      component router
    end
  end
end
