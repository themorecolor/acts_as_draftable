module ActsAsDraftable
  module Ownerable

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def acts_as_ownerable
        has_many :drafts, as: :ownerable
      end

    end

  end
end