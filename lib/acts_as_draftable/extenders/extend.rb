module ActsAsDraftable
  module Extenders

    module Extend

      def acts_as_ownerable
        require 'acts_as_draftable/ownerable'
        include ActsAsDraftable::Ownerable
      end

      def acts_as_draftable
        require 'acts_as_draftable/draftable'
        include ActsAsDraftable::Draftable
      end

    end

  end
end
