class Task < ApplicationRecord
  belongs_to :project
  validates :name, length: {minimum: 1}, presence: true
end
