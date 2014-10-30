require 'active_support/concern'

module ActsAsDraftable
  module Draftable
    extend ActiveSupport::Concern

    included do

      has_many :drafts, as: :draftable

      def draft_update(params)
        self.assign_attributes(params)
        if self::Need_draft_attributes.present?
          draft_check_save
        else
          draft_all_save
        end
      end

      def draft_check_save
        if self.changed?
          draft_res = {}
          no_draft_res = {}
          self.class.column_names.each do |name|
            if self.send("#{name}_changed?")
              if self::Need_draft_attributes.include? name.to_sym
                draft_res[name] = self.send(name)
              else
                no_draft_res[name] = self.send(name)
              end
            end
          end
          self.drafts.create(content: draft_res, active: 1)
          self.update(no_draft_res)
        end
      end

      def draft_all_save
        if self.changed?
          res = {}
          self.class.column_names.each do |name|
            res[name] = self.send(name) if self.send("#{name}_changed?")
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