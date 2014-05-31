module ActiveAdmin
  module LTE
    module Application
      def self.included(base)
        base.extend ClassMethods
        base.class_eval do
          remove_method :setup!
        end
        base.re_setup!
      end

      def setup!
        register_stylesheet 'admin-lte/base.css',       media: 'screen'
        register_javascript 'admin-lte/base.js'
        register_stylesheet 'active_admin',       media: 'screen'
      end

      module ClassMethods
        def re_setup!
          inheritable_setting :view_factory, ActiveAdmin::LTE::ViewFactory.new
        end
      end
    end
  end
end
ActiveAdmin::Application.send(:include, ActiveAdmin::LTE::Application)
