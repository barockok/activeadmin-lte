module ActiveAdmin
  module LTE
    module Views

      class SiteTitle < Component

        def build(namespace)
          @namespace = namespace
          options = {id: 'site_title' , class: 'logo'}
          options[:src] = image_path if site_title_image?
          options[:href] = @namespace.site_title_link if site_title_link?
          super(options)

          super(options)
          text_node title_text unless site_title_image?
        end

        def tag_name
          if site_title_image?
            'img'
          elsif site_title_link?
            'a'
          else
            'span'
          end
        end

        private

        def site_title_link?
          @namespace.site_title_link.present?
        end

        def site_title_image?
          @namespace.site_title_image.present?
        end

        def title_text
          helpers.render_or_call_method_or_proc_on(self, @namespace.site_title)
        end

        def image_path
          helpers.render_or_call_method_or_proc_on(self, @namespace.site_title_image)
        end

      end

    end
  end
end
