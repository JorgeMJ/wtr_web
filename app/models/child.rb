class Child < ApplicationRecord
    belongs_to :account
    has_many :words, dependent: :destroy

    validates :name, presence: true, uniqueness: {scope: :account_id}
end
