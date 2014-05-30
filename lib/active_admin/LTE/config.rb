module ActiveAdmin
  module LTE
    module Config
      def registered_js
        @registered_js ||= []
      end

      def add_js name, options
        self.registered_js.push({file: name, options: options})
      end

      def title_bar= boolean
        @title_bar = boolean
      end

      def title_bar
        @title_bar
      end

    end
  end
end
