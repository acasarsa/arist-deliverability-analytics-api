class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # overides defualt ordering on models with UUID primary keys so that .first / .last work 
  self.implicit_order_column = :created_at
end
