module ActiveAdmin
  module LTE
    module Views

      class ActionItems < ActiveAdmin::Component

        def build(action_items)
          action_items.each do |action_item|
            span class: "action_item" do
              instance_exec(&action_item.block)
            end
          end
        end

        def text_for_default_action_item text, icon_class
          text = <<-END.strip_heredoc.html_safe
          <i class="#{icon_class}"></i> #{text}
          END
        end
      end
    end
  end
end
