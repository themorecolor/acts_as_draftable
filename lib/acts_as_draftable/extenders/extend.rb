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
        def acts_as_draftable
          require 'acts_as_draftable/draftable'
          include ActsAsDraftable::Draftable
        end
      end

      module Tools
        def draft_attributes(*args)
          class_eval do
            attr_accessor :attributes_need_draft
          end
          self.attributes_need_draft = args
        end
      end

    end

  end
end
