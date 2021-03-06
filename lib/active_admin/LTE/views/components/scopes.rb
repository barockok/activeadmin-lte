require 'active_admin/helpers/collection'
require 'active_admin/view_helpers/method_or_proc_helper'

module ActiveAdmin
  module LTE
    module Views

      # Renders a collection of ActiveAdmin::Scope objects as a
      # simple list with a seperator
      class Scopes < ActiveAdmin::Component
        builder_method :scopes_renderer

        include ActiveAdmin::ScopeChain
        include ::ActiveAdmin::Helpers::Collection


        def default_class_name
          "scopes table_tools_segmented_control"
        end

        def tag_name
          'div'
        end

        def build(scopes, options = {})
          build_remove_scope_scope
          scopes.each do |scope|
            build_scope(scope, options) if call_method_or_proc_on(self, scope.display_if_block)
          end
        end

        def build_remove_scope_scope
          return unless request.query_parameters[:scope]
          params     = request.query_parameters.except :scope
          span do
            a 'Reset Scope', href: url_for(params), class: 'table_tools_button btn btn-sm btn-default' do
              i class: 'fa fa-ban'
            end
          end
        end

        protected

        def build_scope(scope, options)
          span class: classes_for_scope(scope) do
            scope_name = I18n.t "active_admin.scopes.#{scope.id}", default: scope.name
            params     = request.query_parameters.except :page, :scope, :commit, :format

            link_class = ['table_tools_button btn btn-sm']
            link_class << (current_scope?(scope) ? 'btn-success' : 'btn-default' )
            counter_class = ['count']
            counter_class << (current_scope?(scope) ? 'badge' : 'badge bg-olive')
            a href: url_for(scope: scope.id, params: params), class: link_class.join(' ') do
              text_node scope_name
              span class: counter_class.join( ' ' ) do
                "#{get_scope_count(scope)}"
              end if options[:scope_count] && scope.show_count
            end
          end
        end

        def classes_for_scope(scope)
          classes = ["scope", scope.id]
          classes << "selected" if current_scope?(scope)
          classes.join(" ")
        end

        def current_scope?(scope)
          if params[:scope]
            params[:scope] == scope.id
          else
            active_admin_config.default_scope(self) == scope
          end
        end

        # Return the count for the scope passed in.
        def get_scope_count(scope)
          collection_size(scope_chain(scope, collection_before_scope))
        end
      end
    end
  end
end
