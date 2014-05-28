module ActiveAdmin
  module LTE
    module Views
      class BatchActionDropdown < ActiveAdmin::Component
        builder_method :batch_action_dropdown

        def build(batch_actions)
          @batch_actions = Array(batch_actions)
          @drop_down = build_drop_down
        end

        private
        def build_drop_down
# <div class="btn-group">
#   <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
#     Action <span class="caret"></span>
#   </button>
#   <ul class="dropdown-menu" role="menu">
#     <li><a href="#">Action</a></li>
#     <li><a href="#">Another action</a></li>
#     <li><a href="#">Something else here</a></li>
#     <li class="divider"></li>
#     <li><a href="#">Separated link</a></li>
#   </ul>
# </div>
          div  class: 'btn-group' do
            button I18n.t("active_admin.batch_actions.button_label"), 
              type: 'button' ,
              class: 'btn btn-default dropdown-toggle btn-sm',
              'data-toggle'=> 'dropdown' do
                span class: 'caret'
            end
            ul class: 'dropdown-menu', role: 'menu' do
              batch_actions_to_display.each do |batch_action|
                confirmation_text = render_or_call_method_or_proc_on(self, batch_action.confirm)

                options = {
                  :class         => "batch_action",
                  "data-action"  => batch_action.sym,
                  "data-confirm" => confirmation_text,
                  "data-inputs"  => batch_action.inputs.to_json
                }

                default_title = render_or_call_method_or_proc_on(self, batch_action.title)
                title = I18n.t("active_admin.batch_actions.labels.#{batch_action.sym}", default: default_title)
                label = I18n.t("active_admin.batch_actions.action_label", title: title)

                li do
                  a label, "#", options
                end
              end
            end
          end
        end

        # Return the set of batch actions that should be displayed
        def batch_actions_to_display
          @batch_actions.select do |batch_action|
            call_method_or_proc_on(self, batch_action.display_if_block)
          end
        end

      end
    end
  end
end

ActiveAdmin.before_load do |app|
  app.view_factory.register batch_action_dropdown: ActiveAdmin::LTE::Views::BatchActionDropdown
end
