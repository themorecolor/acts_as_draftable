module ActsAsDraftable
  class Draft < ::ActiveRecord::Base

    self.abstract_class = true
    establish_connection :backoffice

    def self.table_name_prefix
      self.connection.current_database + '.'
    end

    serialize :content

    belongs_to :draftable, :polymorphic => true
    belongs_to :ownerable, :polymorphic => true

    default_scope { order(created_at: :desc) }
    scope :active, -> { where(active: 1) }

    scope :editting, -> { where(verified: -1) }
    scope :verified_false, ->{where(verified: -2)}
    scope :wait_verified, ->{where(verified: 0)}
    scope :verified_true, ->{where(verified: 1)}


    def unactive
      update(active: 0)
    end

    def active?
      active == 1
    end

    def is_waitting_verified?
      verified == 0
    end

    def is_editting?
      verified == -1
    end

    def to_online(verfied_mome, operator)
      self.draftable.update!(self.content_as_json)
      if operator.blank?
        self.update(verified: 1, verfied_mome: verfied_mome)
      else
        self.update(verified: 1, operater_id: operator.try(:id), verified_memo: verfied_mome)
      end
      self.draftable.update(verified: 1)
    end

    def to_offline(verfied_mome, operator)
      if operator.blank?
        self.update(verified: -2, verfied_mome: verfied_mome)
      else
        self.update(verified: -2, operater_id: operator.try(:id), verified_memo: verfied_mome)
      end
      self.draftable.update(verified: -2)
    end

    def content_as_json
      self.content
    end

    def operator_name
      Operator.find(operator_id).try(:name) unless operator_id.blank?
    end

  end
end