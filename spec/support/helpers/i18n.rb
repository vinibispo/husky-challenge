# spec helpers for i18n
module Helpers::I18n
  # :reek:UtilityFunction
  def field(scope)
    ::I18n.t(scope, scope: 'forms.labels')
  end

  # :reek:UtilityFunction
  def button(scope)
    ::I18n.t(scope, scope: 'forms.buttons')
  end

  # :reek:UtilityFunction
  def flash(scope)
    ::I18n.t(scope, scope: 'flash')
  end
end
