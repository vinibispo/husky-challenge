# form helper for forms
module FormHelper
  # :reek:UtilityFunction
  def create_or_update(object)
    return :submit if object.nil?
    return 'update' if object.persisted?

    'create'
  end
end
