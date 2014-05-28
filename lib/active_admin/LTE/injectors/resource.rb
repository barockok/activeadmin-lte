# require 'active_admin/resource'
module ActiveAdmin
  module LTE
    module Injectors
      module Resource
        def self.included(base)
          base.send :alias_method, :find_index_class, :new_find_index_class
          base.send :alias_method, :add_default_action_items, :new_add_default_action_items
          base.send :alias_method, :add_filters_sidebar_section, :new_add_filters_sidebar_section
        end

        def new_add_default_action_items
          # New link on index
          add_action_item only: :index do
            if controller.action_methods.include?('new') && authorized?(ActiveAdmin::Auth::CREATE, active_admin_config.resource_class)
              link_text = text_for_default_action_item \
                I18n.t('active_admin.new_model', model: active_admin_config.resource_label),
                'fa fa-plus-circle'
              link_to link_text, new_resource_path, class: 'btn bg-olive'
            end
          end

          # Edit link on show
          add_action_item only: :show do
            if controller.action_methods.include?('edit') && authorized?(ActiveAdmin::Auth::UPDATE, resource)
              link_text = text_for_default_action_item \
                I18n.t('active_admin.edit_model', model: active_admin_config.resource_label),
                'fa fa-pencil'
              link_to link_text, edit_resource_path(resource), class: 'btn bg-orange'
            end
          end

          # Destroy link on show
          add_action_item only: :show do
            if controller.action_methods.include?('destroy') && authorized?(ActiveAdmin::Auth::DESTROY, resource)
              link_text = text_for_default_action_item \
                I18n.t('active_admin.delete_model', model: active_admin_config.resource_label),
                'fa fa-ban'
              link_to link_text, resource_path(resource),
                method: :delete, data: {confirm: I18n.t('active_admin.delete_confirmation')}, class: 'btn btn-danger'
            end
          end
        end

        def new_add_filters_sidebar_section
          # don nothing
        end

        def new_find_index_class(symbol_or_class)
          case symbol_or_class
          when Symbol
            ::ActiveAdmin::LTE::Views.const_get("IndexAs" + symbol_or_class.to_s.camelcase)
          when Class
            symbol_or_class
          end
        end

      end
    end
  end
end
