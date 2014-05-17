module ActiveAdmin
  module LTE
    class Railtie < Rails::Railtie
      initializer "active_admin_lte.inject_controller_mixin" do
        ActiveAdmin::BaseController.send(:include, ControllerMixin)
      end
    end
  end
end
