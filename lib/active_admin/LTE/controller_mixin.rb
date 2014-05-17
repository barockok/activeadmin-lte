module ActiveAdmin
  module LTE
    module ControllerMixin
      def self.included(base)
        base.prepend_view_path File.dirname(__FILE__)+'/views'
      end
    end
  end
end
