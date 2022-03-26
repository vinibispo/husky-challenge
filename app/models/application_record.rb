class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include AttrKeyring.active_record
end
