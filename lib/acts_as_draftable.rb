require "acts_as_draftable/version"

module ActsAsDraftable
  # Your code goes here...
  require 'acts_as_draftable/extenders/extend'
  require 'acts_as_draftable/draft'

  ActiveRecord::Base.extend ActsAsDraftable::Extenders::Extend

end
