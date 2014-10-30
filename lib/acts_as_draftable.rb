require "acts_as_draftable/version"

module ActsAsDraftable
  # Your code goes here...
  require 'acts_as_draftable/draft'
  require 'acts_as_draftable/extenders/extend'

  ActiveRecord::Base.extend ActsAsDraftable::Extenders::Extend

end
