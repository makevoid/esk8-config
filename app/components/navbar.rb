class NavBar
  include Inesita::Component

  def render
    nav class: 'materialize-red lighten-2', role: 'navigation' do
      div class: 'nav-wrapper container' do
        a class: 'brand-logo' do
          text "VESC Config Tool"
        end
      end
      # <div class="nav-wrapper container"><a id="logo-container" href="#" class="brand-logo">Logo</a>
      #   <ul class="right hide-on-med-and-down">
      #     <li><a href="#">Navbar Link</a></li>
      #   </ul>
      #
      #   <ul id="nav-mobile" class="side-nav" style="transform: translateX(-100%);">
      #     <li><a href="#">Navbar Link</a></li>
      #   </ul>
      #   <a href="#" data-activates="nav-mobile" class="button-collapse"><i class="material-icons">menu</i></a>
      # </div>
    end
    # nav class: 'navbar navbar-default' do
    #   div class: 'container' do
    #     div class: 'navbar-header' do
    #       span class: 'navbar-brand' do
    #         text 'Esk8 Calc'
    #       end
    #       ul class: 'nav navbar-nav' do
    #         li class: "#{"active" if router.current_url?(:home)}" do
    #           a href: router.url_for(:home) do
    #             text 'Home'
    #           end
    #         end
    #       end
    #     end
    #   end
    # end
  end
end
