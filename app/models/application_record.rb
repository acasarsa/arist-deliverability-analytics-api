class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # overides defualt ordering on models with UUID primary keys so that .first / .last work 
  self.implicit_order_column = :created_at
  default_scope { order('created_at') } # json will be ordered by created_at 
end
