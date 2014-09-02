module ActiveAdmin
  module LTE
    module Views
      module Pages
        class Base < Arbre::HTML::Document

          def build(*args)
            super
            add_classes_to_body
            build_active_admin_head
            build_page
          end

          private

          def build_page_tools
            div class: 'box', id: 'page-tool' do
              div class: 'box-body' do
                div class: 'box-tools pull-right' do
                  build_action_items
                end
              end
            end
          end

          def add_classes_to_body
            @body.add_class(params[:action])
            @body.add_class(params[:controller].gsub('/', '_'))
            @body.add_class("active_admin")
            @body.add_class("logged_in")
            @body.add_class(active_admin_namespace.name.to_s + "_namespace")
            @body.add_class('skin-blue')
          end

          def build_active_admin_head
            within @head do
              insert_tag Arbre::HTML::Title, [title, render_or_call_method_or_proc_on(self, active_admin_application.site_title)].join(" | ")
              active_admin_application.stylesheets.each do |style, options|
                text_node stylesheet_link_tag(style, options).html_safe
              end

              active_admin_application.javascripts.each do |path|
                text_node(javascript_include_tag(path))
              end

              if active_admin_application.favicon
                text_node(favicon_link_tag(active_admin_application.favicon))
              end

              text_node csrf_meta_tag
            end
          end

          def build_page
            within @body do
              build_header
              div class: "wrapper row-offcanvas row-offcanvas-left" do
                aside class: "left-side sidebar-offcanvas" do
                  section class: "sidebar" do
                    build_user_panel
                    build_global_navigation
                  end
                end
                aside class: "right-side" do
                  build_title_bar unless active_admin_config.title_bar == false
                  build_page_content
                  build_footer
                end
              end
            end
          end

          def build_action_items
            action_items = action_items_for_action
            insert_tag(view_factory.action_items, action_items  ) if action_items.any?
          end

          def build_header
            insert_tag view_factory.header, active_admin_namespace, current_menu
          end

          def build_title_bar
            insert_tag view_factory.title_bar, title, action_items_for_action
          end

          def build_global_navigation
            insert_tag view_factory.global_navigation, current_menu
          end

          def build_page_content
            section class: "content" do
              div class: 'row' do
                div class: 'col-md-12' do
                  # build_page_tools
                  build_flash_messages
                  build_main_content_wrapper
                  build_sidebar unless skip_sidebar?
                end
              end
            end
          end

          def build_user_panel
            raw = <<-END.strip_heredoc
                  <div class="user-panel">
                      <div class="pull-left image">
                          <img src="#{avatar_path}" class="img-circle" alt="#{avatar_alt}" />
                      </div>
                      <div class="pull-left info">
                          <p>Hello, <span class="avatar-name">#{avatar_name}</span></p>
                      </div>
                  </div>
                  END
            text_node raw.html_safe
          end

          def avatar_path
            avatar_file = "admin-lte/avatar#{(1..6).to_a.sample}.png"
            image_path(avatar_file)
          end

          def avatar_name
           display_name current_active_admin_user
          end

          def avatar_alt
            "some user"
          end

          def build_flash_messages
            flash_type_map = {
              "alert" => 'warning',
              "notice" =>'success'
            }
            if active_admin_flash_messages.any?
              div class: 'flashes no-print' do
                active_admin_flash_messages.each do |type, message|
                  flash_type = flash_type_map[type.to_s]
                  div class: "flash flash_#{type} alert alert-#{flash_type}" do
                    build_flash_icon flash_type
                    text_node message
                  end
                end
              end
            end
          end

          def build_flash_icon flash_type
            icon_class_map ={
              'alert'  => 'fa fa-check',
              'success'=> 'fa fa-check',
              'warning'=> 'fa fa-warning',
            }

            raw = <<-END.strip_heredoc
              <div class="alert-icon">
              <i class="#{icon_class_map[flash_type]}"></i>
              </div>
            END

            text_node raw.html_safe
          end

          def build_main_content_wrapper
            div id: "main_content_wrapper" do
              div id: "main_content" do
                main_content
              end
            end
          end

          def main_content
            I18n.t('active_admin.main_content', model: self.class.name).html_safe
          end

          def title
            self.class.name
          end

          # Set's the page title for the layout to render
          def set_page_title
            set_ivar_on_view "@page_title", title
          end

          # Returns the sidebar sections to render for the current action
          def sidebar_sections_for_action
            if active_admin_config && active_admin_config.sidebar_sections?
              active_admin_config.sidebar_sections_for(params[:action], self)
                .select{|section| section.name != :filters}
            else
              []
            end
          end

          def action_items_for_action
            if active_admin_config && active_admin_config.action_items?
              active_admin_config.action_items_for(params[:action], self)
            else
              []
            end
          end

          # Renders the sidebar
          def build_sidebar
            div id: "sidebar" do
              sidebar_sections_for_action
                .collect do |section|
                sidebar_section(section)
              end
            end
          end

          def skip_sidebar?
            sidebar_sections_for_action.empty? || assigns[:skip_sidebar] == true
          end

          # Renders the content for the footer
          def build_footer
            insert_tag view_factory.footer
            div style: 'display: none' do
              active_admin_config.registered_js.each do |js|
                text_node(javascript_include_tag('/'+js[:file]))
              end
            end
          end

        end
      end
    end
  end
end
