module ActiveAdmin
  module LTE
    module Inputs
      class BooleanInput <FormtasticBootstrap::Inputs::BooleanInput
        def to_html
          checkbox_wrapping do
            hidden_field_html <<
            "<div class='col-sm-offset-2 col-sm-10'><div class='radio'>".html_safe <<
            "".html_safe <<
            [label_with_nested_checkbox, hint_html].join("\n").html_safe <<
            "</div></div>".html_safe
          end
        end

        def checkbox_wrapping(&block)
          template.content_tag(:div,
            template.capture(&block).html_safe,
            wrapper_html_options,
            :class => "form-wrapper #{wrapper_class}"
          )
        end

        def label_html_options
          super.tap do |options|
            old_class = options[:class] || []
            old_class.delete ' col-sm-2'
            options[:class] = (old_class + ["checkbox"]).join(" ")
          end
        end
      end
    end
  end
end
