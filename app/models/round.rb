class Round < ApplicationRecord
  belongs_to :post
  
  validates :score, presence: true
  validates :round_number, inclusion: { in: [*1..18] }
  
  enum score: { eagle: 2,
                burdy: 3,
                par: 4,
                bogey: 5,
                double_bogy: 6,
                triple_bogy: 7,
                plus_4: 8,
                plus_5: 9,
                plus_6: 10,
                plus_7: 11,
                plus_8: 12,
                plus_9: 13 }
                validates :score, inclusion: { in: Round.scores.keys }
                
end
