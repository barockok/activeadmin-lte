module ActiveAdmin
  module LTE
    module Views
      module Pages
        class Layout < Base

          def title
            'Amin LTE'
          end

          def main_content
            content_for_layout = content_for(:layout)
            if content_for_layout.is_a?(Arbre::Element)
              current_arbre_element.add_child content_for_layout.children
            else
              text_node content_for_layout
            end
          end
        end
      end
    end
  end
end
