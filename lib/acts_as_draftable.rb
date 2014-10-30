require "acts_as_draftable/version"

module ActsAsDraftable
  # Your code goes here...
  require 'acts_as_draftable/draft'

  ActiveRecord::Base.extend ActsAsVotable::Extenders::Extend

end
