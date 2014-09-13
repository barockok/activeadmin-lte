module ActiveAdmin
  module LTE
    module DSL
      def js name, options={}
        config.add_js name, options
      end

      def title_bar= boolean
        config.title_bar = boolean
      end

      def form(options = {}, &block)
        # config.set_page_presenter :form, ActiveAdmin::PagePresenter.new(options, &block)
      end
    end
  end
end
