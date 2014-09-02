module ActiveAdmin::LTE
  class Engine < ::Rails::Engine
    initializer "ActiveAdmin-LTE precompile hook", group: :all do |app|
      app.config.assets.precompile += %w(admin-lte/base.css admin-lte/base.js)
    end
  end
end
