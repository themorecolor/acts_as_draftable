module ActsAsDraftable
  module Ownerable

    def self.included(base)
      base.class_eval do

        has_many :drafts, as: :ownerable


      end
    end

  end
end