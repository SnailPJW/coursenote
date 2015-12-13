class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true, counter_cache: true, touch: true
  belongs_to :user

  after_save :update_score
  after_save :course_received_vote

  validates_uniqueness_of :user_id, scope: [:votable_id, :votable_type]
  validates_presence_of :votable, :user

  private

  def update_score
    history = changes['upvote'] || [nil, nil]
    lookup = { nil => 0, true => 1, false => -1 }

    diff = -lookup[history[0]] + lookup[history[1]]
    votable.update(score: votable.score + diff)
  end

  def course_received_vote
    if votable_type == 'Course' && !votable.received_vote
      votable.update(received_vote: true)
    end
  end
end
