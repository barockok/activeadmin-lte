# require 'active_admin/resource'
module ActiveAdmin
  module LTE
    module Injectors
      module Resource
        def self.included(base)
          base.send :alias_method, :find_index_class, :new_find_index_class
        end
        def new_find_index_class(symbol_or_class)
          puts "ActiveAdmin::PagePresenters injected"
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
ActiveAdmin::Resource.send :include, ActiveAdmin::LTE::Injectors::Resource
