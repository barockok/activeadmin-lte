module ActiveAdmin
  module LTE
    class Railtie < Rails::Engine
      initializer "ActiveAdmin precompile hook", group: :all do |app|
        app.config.assets.precompile += %w(admin-lte/base.css admin-lte/base.js)
      end
    end
  end
end
