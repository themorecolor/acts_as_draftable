# encoding: utf-8
module ActsAsTaggableOn
  class Draft < ::ActiveRecord::Base

    belongs_to :draftable, :polymorphic => true

    scope :active, -> { where(active: 1) }



  end
end
