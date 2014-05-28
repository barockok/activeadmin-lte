module ActiveAdmin
  module LTE
    module JS
      def registered_js
        @registered_js ||= []
      end

      def add_js name, options
        self.registered_js.push({file: name, options: options})
      end
    end
  end
end
