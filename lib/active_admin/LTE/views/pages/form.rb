module ActiveAdmin
  module LTE
    module Views
      module Pages
        class Form < Base
          def title
            assigns[:page_title] || I18n.t("active_admin.#{params[:action]}_model",
                                           model: active_admin_config.resource_label)
          end

          def form_presenter
            active_admin_config.get_page_presenter(:form) || default_form_config
          end

          def main_content
            options = default_form_options.merge form_presenter.options

            if options[:partial]
              render options[:partial]
            else
              div class: 'row' do
                div class: 'col-md-8' do
                  active_admin_lte_form_for resource, options do |f|
                    instance_exec f, &form_presenter.block
                  end
                end
              end
            end
          end

          private

          def default_form_options
            {
              url: default_form_path,
              as: active_admin_config.resource_name.singular
            }
          end

          def default_form_path
            resource.persisted? ? resource_path(resource) : collection_path
          end

          def default_form_config
            ActiveAdmin::PagePresenter.new do |f|
              attributes = f.send(:default_columns_for_object)
              inputs = f.inputs.to_str

              content = content_tag :div, class: 'box-body' do
                inputs.html_safe
              end.html_safe

              footer = content_tag :div, class: 'box-footer' do
                f.submit(class: 'btn btn-primary').html_safe +
                link_to("Cancel <i class='fa fa-times'></i>".html_safe, url_for(action: :index), class: 'btn btn-warning cancel-btn')
              end.html_safe

              content_tag :div, class: 'box' do
                content + footer
              end.html_safe
            end
          end
        end
      end
    end
  end
end
