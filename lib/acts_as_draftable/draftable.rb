require 'active_support/concern'

module ActsAsDraftable
  module Draftable
    extend ActiveSupport::Concern

    included do

      has_many :drafts, as: :draftable

      def draft_save
        if self.changed?
          res = {}
          (self.class.column_names - ["id", "updated_at", "created_at"]).each do |name|
            if self.send("#{name}_changed?")
              res[name] = self.send(name)
            end
          end
          self.drafts.create(content: res, active: 1)
        end
      end

      def last_active_draft
        draft = self.drafts.order(created_at: :desc).first
        draft.active? ? draft : nil
      end

      def last_active_draft_to_online(operator = nil)
        last_active_draft.to_online(operator) unless last_active_draft.blank?
      end

    end

    module ClassMethods

    end

  end
end