require "active_admin/LTE/version"
require "quiet_assets"

module ActiveAdmin
  module LTE
    autoload :ViewFactory,              'active_admin/LTE/view_factory'
    autoload :Views,                    'active_admin/LTE/views'
  end
end

require "active_admin/LTE/application"
require "active_admin/LTE/controller_mixin"
require "active_admin/LTE/railtie"
