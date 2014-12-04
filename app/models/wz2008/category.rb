require 'ancestry'
module Wz2008
  class Category < ActiveRecord::Base
    has_ancestry :cache_depth => true
    scope :isic, -> { where('isic is not null')}

    def wz_code_list
      wz_code.split('.')
    end

    before_create do

      self.hierarchy = case wz_code
                       when /^[A-Z]+$/ then 'Section'
                       when /^\d+$/ then 'Division'
                       when /^\d+\.\d$/ then 'Group'
                       when /^\d+\.\d\d$/ then 'Class'
                       when /^\d+\.\d\d\.\d$/ then 'Sub-Class'
                       end

    end
  end
end
