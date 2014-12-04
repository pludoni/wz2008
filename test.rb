require 'wz2008/import'
Wz2008::Import.run()

Wz2008::Category.count > 1000 || (raise StandardError.new('Expectation not met'))
