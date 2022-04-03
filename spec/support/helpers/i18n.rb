# spec helpers for i18n
module Helpers::I18n
  def field(scope)
    ::I18n.t(scope, scope: 'forms.labels')
  end

  def button(scope)
    ::I18n.t(scope, scope: 'forms.buttons')
  end
end
