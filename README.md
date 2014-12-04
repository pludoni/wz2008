# WZ2008 Categories of sectors

Categories issued by German statistical department as a ActiveRecord tree structure (German) with German and English classification names.
https://www.destatis.de/DE/Methoden/Klassifikationen/GueterWirtschaftklassifikationen/Content75/KlassifikationWZ08.html

(International Standard Industrial Classification of all Economic Activities)
See also: ISIC -> http://unstats.un.org/unsd/cr/registry/regcst.asp?Cl=27

Installation: add to Gemfile + bundle

```
rake wz2008:install:migrations
rake db:migrate
rails r "require 'wz2008/import'; Wz2008::Import.run()"
```

Afterwards, you have a filled database with about 1800 categories ordered in a structure via Ancestry Gem.


e.g.:

```ruby
Wz2008::Category.roots.map do |root|
  [ root.description, root.children.map(&:description_en) ]
end
```

See documentation of Ancestry for usage.


Extra features:

```ruby
Wz2008::Category.isic # only Categories with ISIC classification

Wz2008::Category.group(:hierarchy).count # Hierarchy levels of the WZ2008
```
