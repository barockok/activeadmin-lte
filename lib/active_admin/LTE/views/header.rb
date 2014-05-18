module ActiveAdmin
  module LTE
    module Views
      class Header < Component

        def tag_name
          'header'
        end

        def build(namespace, menu)
          super(id: "header")

          @namespace = namespace
          @menu = menu
          @utility_menu = @namespace.fetch_menu(:utility_navigation)

          build_site_title
          # build_global_navigation
          build_navbar
        end


        def build_site_title
          insert_tag view_factory.site_title, @namespace
        end

        def build_navbar
          nav class: 'navbar navbar-static-top', role: 'navigation' do
            build_navbar_sidebar_toggle
            div class: 'navbar-right' do
              build_utility_navigation
            end
          end
        end

        def build_navbar_sidebar_toggle
          raw = <<-END.strip_heredoc
            <a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
          END
          text_node raw.html_safe
        end

        # def build_global_navigation
        #   insert_tag view_factory.global_navigation, @menu, class: 'header-item tabs'
        # end

        def build_utility_navigation
          insert_tag view_factory.utility_navigation, @utility_menu, id: "utility_nav"
        end

      end
    end
  end
end
