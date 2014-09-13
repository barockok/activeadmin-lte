module ActiveAdmin
  module LTE
    module ViewHelpers
      # Helper method to render a filter form
      def active_admin_lte_form_for resource, options = {}, &block
        options = Marshal.load( Marshal.dump(options) )
        options[:builder] ||= ActiveAdmin::LTE::FormBuilder
        options[:html] ||= {}
        options[:html][:class] ||= ''
        options[:html][:class] += ' lte-resource-form form-horizontal'

        semantic_form_for resource, options, &block
      end

      def active_admin_filters_form_for(search, filters, options = {})
        defaults = { builder: ActiveAdmin::Filters::FormBuilder,
                     url: collection_path,
                     html: {class: 'filter_form'} }
        required = { html: {method: :get},
                     as: :q }
        options  = defaults.deep_merge(options).deep_merge(required)

        form_for search, options do |f|
          filters.each do |attribute, opts|
            next if opts.key?(:if)     && !call_method_or_proc_on(self, opts[:if])
            next if opts.key?(:unless) &&  call_method_or_proc_on(self, opts[:unless])
            f.filter attribute, opts.except(:if, :unless)
          end

          clear_filter = url_for(params.except(:q, :page, :commit,:utf8))
          buttons = content_tag :div, class: "actions" do
            f.submit(I18n.t('active_admin.filters.buttons.filter'), class: 'btn btn-primary btn-flat') +
              link_to(I18n.t('active_admin.filters.buttons.clear'), clear_filter, class: 'clear_filters_btn btn btn-flat btn-default') +
              hidden_field_tags_for(params, except: [:q, :page])
          end

          final_buffer = <<-END.strip_heredoc.html_safe
            <div class="filter-wrapper">
              #{f.form_buffers.last}
            </div>
            #{buttons}
          END
          final_buffer
        end
      end
    end
  end
end
