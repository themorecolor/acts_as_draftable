# encoding: utf-8
module ActsAsDraftable
  class Draft < ::ActiveRecord::Base

    serialize :content

    belongs_to :draftable, :polymorphic => true
    belongs_to :ownerable, :polymorphic => true

    scope :active, -> { where(active: 1) }

    def unactive
      update(active: 0)
    end

    def active?
      active == 1
    end

    def to_online(operator = nil)
      self.draftable.update!(self.content_as_json)
      unless operator.blank?
        self.update(active: 0)
      else
        self.update(active: 0, operator_id: operator.id)
      end
    end

    def content_as_json
      YAML.load(self.content)
    end


  end
end
