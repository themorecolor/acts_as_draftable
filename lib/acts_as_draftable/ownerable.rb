require 'active_support/concern'

module ActsAsDraftable
  module Ownerable

    extend ActiveSupport::Concern

    included base do
      has_many :drafts, as: :ownerable
    end


  end
end