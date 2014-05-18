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
          build_title_tag
        end

        def build_titlebar_right
          build_breadcrumb
          # div id: "titlebar_right" do
          #   build_action_items
          # end
        end

        def build_breadcrumb(separator = "/")
          breadcrumb_config = active_admin_config && active_admin_config.breadcrumb

          links = if breadcrumb_config.is_a?(Proc)
            instance_exec(controller, &active_admin_config.breadcrumb)
          elsif breadcrumb_config.present?
            breadcrumb_links
          end
          return unless links.present? && links.is_a?(::Array)
          ol class: "breadcrumb" do
            links.each do |link|
              li do
                text_node link
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
