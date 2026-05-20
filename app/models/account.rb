class Account < ApplicationRecord
  has_many :custodians, dependent: :destroy
  has_many :children, dependent: :destroy
end
