module ActsAsDraftable
  module Extenders

    module Extend

      module Ownerable
        def acts_as_ownerable
          require 'acts_as_draftable/ownerable'
          include ActsAsDraftable::Ownerable
        end
      end

      module Draftable
        def acts_as_draftable(*args)
          require 'acts_as_draftable/draftable'
          include ActsAsDraftable::Draftable

          class_eval do
            class_attribute :need_verified_fields
            self.need_verified_fields = args
          end

        end
      end

    end

  end
end
