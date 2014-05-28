module ActiveAdmin
  module LTE
    module Views

      class Panel < ActiveAdmin::Component
        builder_method :panel

        def build(title, attributes = {})
          icon_name = attributes.delete(:icon)
          icn = icon_name ? icon(icon_name) : "".html_safe
          super(attributes)
          add_class "box"
          remove_class "panel"
          @title = div class: 'box-header' do
            h3(icn + title.to_s, class: 'box-title')
          end
          @contents = div(class: "box-body no-padding")
        end

        def add_child(child)
          if @contents
            @contents << child
          else
            super
          end
        end

        # Override children? to only report children when the panel's
        # contents have been added to. This ensures that the panel
        # correcly appends string values, etc.
        def children?
          @contents.children?
        end

      end

    end
  end
end
