# form helper for forms
module FormHelper
  def create_or_update(action_name)
    return 'create' if action_name == 'new'
    return 'update' if action_name == 'edit'

    action_name
  end
end
