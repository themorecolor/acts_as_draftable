require 'active_support/concern'

module ActsAsDraftable
  module Ownerable

    extend ActiveSupport::Concern

    included do
      has_many :drafts, class_name: "ActsAsDraftable::Draft", as: :ownerable
    end


  end
end