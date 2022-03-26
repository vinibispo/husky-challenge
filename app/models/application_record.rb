# frozen_string_literal: true

# This class is responsible for integrate ActiveModel with database
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include AttrKeyring.active_record
end
