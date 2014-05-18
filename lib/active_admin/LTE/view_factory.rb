require 'active_admin/abstract_view_factory'

module ActiveAdmin
  module LTE
    class ViewFactory < AbstractViewFactory

      register  global_navigation:   ActiveAdmin::LTE::Views::TabbedNavigation,
                utility_navigation:  ActiveAdmin::LTE::Views::UtilityNavigation,
                site_title:          ActiveAdmin::LTE::Views::SiteTitle,
                action_items:        ActiveAdmin::LTE::Views::ActionItems,
                title_bar:           ActiveAdmin::LTE::Views::TitleBar,
                header:              ActiveAdmin::LTE::Views::Header,
                footer:              ActiveAdmin::LTE::Views::Footer,
                index_scopes:        ActiveAdmin::LTE::Views::Scopes,
                blank_slate:         ActiveAdmin::LTE::Views::BlankSlate,
                action_list_popover: ActiveAdmin::LTE::Views::ActionListPopover

      register  index_page: ActiveAdmin::LTE::Views::Pages::Index,
                show_page:  ActiveAdmin::LTE::Views::Pages::Show,
                new_page:   ActiveAdmin::LTE::Views::Pages::Form,
                edit_page:  ActiveAdmin::LTE::Views::Pages::Form,
                layout:     ActiveAdmin::LTE::Views::Pages::Layout,
                page:       ActiveAdmin::LTE::Views::Pages::Page
      end
  end
end
