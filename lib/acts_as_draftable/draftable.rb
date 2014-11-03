require 'active_support/concern'

module ActsAsDraftable
  module Draftable
    extend ActiveSupport::Concern

    included do

      has_many :drafts, as: :draftable

      def draft_update(params)
        self.assign_attributes(params)

        unless self.valid?
          raise self.errors.full_messages.join(", ")
        end

        if self.class.const_defined? :Need_draft_attributes
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
              if self.class::Need_draft_attributes.include? name.to_sym
                draft_res[name] = self.send(name)
              else
                no_draft_res[name] = self.send(name)
              end
            end
          end

          self.update(no_draft_res) unless no_draft_res.blank?
          self.drafts.create(content: draft_res, active: 1) unless draft_res.blank?
        end
      end

      def draft_all_save
        if self.changed?
          res = {}
          self.class.column_names.each do |name|
            res[name] = self.send(name) if self.send("#{name}_changed?")
          end
          self.drafts.create(content: res, active: 1) unless res.blank?
        end
      end

      def last_active_draft
        draft = self.drafts.order(created_at: :desc).first
        draft.active? ? draft : nil unless draft.blank?
      end

      def last_active_draft_to_online(verfied_mome, operator = nil)
        last_active_draft.to_online(verfied_mome, operator) unless last_active_draft.blank?
      end

      def last_active_draft_to_offline(verfied_mome, operator = nil)
        last_active_draft.to_offline(verfied_mome, operator) unless last_active_draft.blank?
      end

      def with_draft
        unless self.last_active_draft.blank?
          self.assign_attributes(self.last_active_draft.content_as_json)
        end
        self
      end

      def is_need_verified
        last_active_draft.blank? ? 0 : 1
      end

    end

    module ClassMethods

    end

  end
end