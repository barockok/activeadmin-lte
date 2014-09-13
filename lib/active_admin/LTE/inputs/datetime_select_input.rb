module ActiveAdmin
  module LTE
    module Inputs
      class DatetimeSelectInput <FormtasticBootstrap::Inputs::DatetimeSelectInput
        include Formtastic::Inputs::Base::Stringish
        def to_html
          bootstrap_wrapping do
            "<div class='lte-date-time'>".html_safe <<
            ( builder.text_field(method, form_control_input_html_options) + container_tag ).html_safe <<
            "</div>".html_safe
          end
        end

        def container_tag
          <<-HTML.html_safe
          <div class="lte-date-time-container">
            <input type="text" class="date-placeholder hidden"/>
            <input type="text" class="time-placeholder hidden"/>
            <div class="date"></div>
            <div class="time"></div>
          </div>
          HTML
        end

        def form_control_input_html_options
          clone_options = super
          clone_options[:class] = append_class(clone_options[:class] || '')
          clone_options[:value] = current_value if current_value
          clone_options
        end

        def current_value
          original_value = builder.object.send(method)
          original_value = original_value.to_time unless original_value.class < Time
          original_value.strftime('%-d %B, %Y %l:%M %p')
        rescue
          nil
        end

        def append_class current_class=""
          current_class + " lte-date-time-input"
        end
      end
    end
  end
end
