module ActiveAdmin
  module LTE
    module Views
      module Pages
        class Index < ActiveAdmin::Views::Pages::Index
          def title
            super
          end
        end
      end
    end
  end
end
