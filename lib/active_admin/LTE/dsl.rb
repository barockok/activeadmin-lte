module ActiveAdmin
  module LTE
    module DSL
      def js name, options={}
        config.add_js name, options
      end

      def title_bar= boolean
        config.title_bar = boolean
      end
    end
  end
end
