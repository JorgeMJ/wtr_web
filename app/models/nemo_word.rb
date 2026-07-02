class NemoWord < ApplicationRecord
  belongs_to :nemo_child

  validates :word, uniqueness: {scope: :nemo_child_id}
end
