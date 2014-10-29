require "acts_as_draftable/version"

module ActsAsDraftable
  # Your code goes here...

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def acts_as_draftable(options = {})

      has_many :drafts, as: :draftable

      def draft_save
        if self.changed?
          res = []
          (self.class.column_names - ["id", "updated_at", "created_at"]).each do |name|
            if self.send("#{name}_changed?")
              changed_res = {}
              changed_res[name] = self.send("#{name}_change")
              res << changed_res
            end
          end
          self.drafts.create(content: res.to_json)
        end
      end

      def last_active_draft
        self.drafts.active.order(created_at: :desc).first
      end

      def draft_to_

    end

  end


end
