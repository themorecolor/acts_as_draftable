# encoding: utf-8
module ActsAsTaggableOn
  class Draft < ::ActiveRecord::Base

    serialize :content, JSON

    belongs_to :draftable, :polymorphic => true
    belongs_to :ownerable, :polymorphic => true

    scope :active, -> { where(active: 1) }

    def unactive
      update(active: 0)
    end

    def active?
      active == 1
    end


  end
end
