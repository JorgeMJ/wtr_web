class Word < ApplicationRecord
    belongs_to :child

    validates :word, uniqueness: {scope: :child_id}
end
