module ActiveAdmin
  module LTE
    module ResourceDSL
      def self.included(base)
        base.class_eval do
          remove_method :form
        end
      end
      private
      def form(options = {}, &block)
        config.set_page_presenter :form, form_presenter_lte(options, &block)
      end

      def form_presenter_lte options,  &block
        ActiveAdmin::PagePresenter.new(options) do |f|
          f.use_form_dsl = true

          content = content_tag :div, class: 'box-body' do
            instance_exec(f, &block).html_safe
          end.html_safe

          footer = ''
          footer = content_tag :div, class: 'box-footer' do
            f.actions_buffer.join('').html_safe
          end.html_safe if f.action_defined?

          content_tag :div, class: 'box' do
            content + footer
          end.html_safe
        end
      end
    end
  end
end
ActiveAdmin::ResourceDSL.send :include, ActiveAdmin::LTE::ResourceDSL
