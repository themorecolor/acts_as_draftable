require "acts_as_draftable/version"

module ActsAsDraftable
  # Your code goes here...
  extend ActiveSupport::Autoload

  autoload :Draft

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def acts_as_draftable(options = {})

      has_many :drafts, as: :draftable

      def draft_save
        if self.changed?
          res = {}
          (self.class.column_names - ["id", "updated_at", "created_at"]).each do |name|
            if self.send("#{name}_changed?")
              res[name] = self.send(name)
            end
          end
          self.drafts.create(content: res)
        end
      end

      def last_active_draft
        draft = self.drafts.order(created_at: :desc).first
        draft.active? ? draft : nil
      end

      def draft_to_online
        unless last_active_draft.blank?
          self.update!(last_active_draft.content)
          last_active_draft.update(active: 0)
        end
      end

    end

    def acts_as_ownerable
      has_many :drafts, as: :ownerable
    end

  end


end
