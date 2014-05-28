module ActiveAdmin
  module LTE
    module Views
      # Build a Blank Slate
      class BlankSlate < ActiveAdmin::Component
        builder_method :blank_slate

        def default_class_name
          'blank_slate_container text-center'
        end

        def build(content)
          super(h4(content.html_safe, class: "blank_slate"))
        end

      end
    end
  end
end
