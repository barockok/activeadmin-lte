module ActiveAdmin
  module LTE
    module DSL
      def js name, options={}
        config.add_js name, options
      end
    end
  end
end
