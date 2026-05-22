class Account < ApplicationRecord
  has_many :custodians, dependent: :destroy
  has_many :children, dependent: :destroy

  # It says an account belongs to the custodian admin_custodian (Rails translete it to admin_custodian_id)
  # that is in the class "Custodian". i.e. belongs to an object, not a class.
  #  Optional: true means that it can be null (for those custodians that are not admin)
  belongs_to :admin_custodian,
             class_name: "Custodian",
             optional: true

  attr_accessor :parent_name, :parent_email
end
