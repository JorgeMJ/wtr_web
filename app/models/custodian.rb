class Custodian < ApplicationRecord
    belongs_to :account

    validates :email, presence: true
    validates :fname, presence: true
end
