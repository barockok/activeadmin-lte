module ActiveAdmin
  module LTE
    module Injectors
      module FormBuilder
        def self.included base
          puts "Form builder injected"
        end
      end
    end
  end
end
ActiveAdmin::FormBuilder.send :include, ActiveAdmin::LTE::Injectors::FormBuilder
