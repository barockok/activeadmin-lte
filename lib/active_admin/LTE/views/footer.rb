module ActiveAdmin
  module LTE
    module Views
      class Footer < Component

        def build
          super id: "footer"
          powered_by_message
        end

        private

        def powered_by_message
          para 'ActiveAdmin-LTE'
        end

      end
    end
  end
end
