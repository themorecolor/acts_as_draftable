require 'active_record'
require 'active_support/inflector'
require "acts_as_draftable/version"

$LOAD_PATH.unshift(File.dirname(__FILE__))

module ActsAsDraftable
  # Your code goes here...

  require 'acts_as_draftable/extenders/extend'
  require 'acts_as_draftable/draft'

  ActiveRecord::Base.extend ActsAsDraftable::Extenders::Extend::Ownerable
  ActiveRecord::Base.extend ActsAsDraftable::Extenders::Extend::Draftable

end
