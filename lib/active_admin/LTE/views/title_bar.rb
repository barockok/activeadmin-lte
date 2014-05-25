module ActiveAdmin
  module LTE
    module Views
      class TitleBar < Component

        def tag_name
          'section'
        end
        def build(title, action_items)
          super(id: "title_bar", class: "content-header")
          @title = title
          @action_items = action_items
          build_titlebar_left
          build_titlebar_right
        end

        private

        def build_titlebar_left
          build_breadcrumb
          build_title_tag
        end

        def build_titlebar_right
          div class: 'action-items-block' do
            build_action_items
          end
        end

        def breadcrumb_root root_link
          match = root_link.match(/\>(.*)\</)
          text = match[1]
          text_with_icon = "> <i class=\"fa fa-dashboard\"></i>  #{text} <"
          raw_html = root_link.gsub />.*</, text_with_icon
          raw_html.html_safe
        end

        def build_breadcrumb(separator = "/")
          breadcrumb_config = active_admin_config && active_admin_config.breadcrumb

          links = if breadcrumb_config.is_a?(Proc)
            instance_exec(controller, &active_admin_config.breadcrumb)
          elsif breadcrumb_config.present?
            breadcrumb_links
          end
          return unless links.present? && links.is_a?(::Array)
          div class: 'breadcrumb-block' do
            ol class: "breadcrumb" do
              root = links.shift
              li do
                text_node breadcrumb_root(root)
              end
              links.each do |link|
                li do
                  text_node link
                end
              end
            end
          end
        end

        def build_title_tag
          h1(@title, id: 'page_title')
        end

        def build_action_items
          insert_tag(view_factory.action_items, @action_items) if @action_items.any?
        end

      end
    end
  end
end
