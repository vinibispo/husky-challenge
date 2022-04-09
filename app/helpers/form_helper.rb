# form helper for forms
module FormHelper
  def create_or_update(object)
    return 'update' if object&.persisted?

    'create'
  end
end
