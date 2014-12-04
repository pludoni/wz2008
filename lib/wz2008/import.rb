require 'pry'
class Wz2008::Import
  IMPORT = File.join(File.dirname(File.expand_path(__FILE__)), '../../data/original.tsv')
  ENGLISH = File.join(File.dirname(File.expand_path(__FILE__)), '../../data/english.tsv')

  def self.run
    puts 'Deleting categories....'
    Wz2008::Category.delete_all
    puts 'Importing categories....'
    create_categories
    puts 'Set tree structure...'
    set_tree
    puts "Importing English..."
    import_english
    puts "Finished with #{Wz2008::Category.count} categories"
  end

  def self.import_english
    headlines = [:lfdnr, :wzcode, :bezeichnung, :isic]
    couples = File.read(ENGLISH).lines.map{|l|
      t = l.split("\t")
      Hash[headlines.zip(t)]
    }
    couples.each do |item|
      Wz2008::Category.find(item[:lfdnr]).update_attributes(description_en: item[:bezeichnung])
    end
  end

  def self.set_tree
    Wz2008::Category.where('ancestry is not null').find_each do |c|
      parent_code = nil
      case c.wz_code
      when /^(\d+\.\d+)\.\d+$/ then parent_code = $1
      when /^(\d+\.\d)\d$/ then parent_code = $1
      when /^(\d+)\.\d$/ then parent_code = $1
      end

      if parent_code
        c.parent = Wz2008::Category.where(wz_code: parent_code).first
        # puts "#{c.wz_code} -> #{c.parent.wz_code}"
        c.save
      end
    end
  end

  def self.create_categories
    headlines = [:lfdnr, :wzcode, :bezeichnung, :isic]
    couples = File.read(IMPORT).lines.map{|l|
      t = l.split("\t")
      Hash[headlines.zip(t)]
    }
    current_category = nil
    couples.each do |item|
      c = Wz2008::Category.new
      c.id = item[:lfdnr]
      c.wz_code = item[:wzcode]
      c.description_de = item[:bezeichnung]
      c.isic = item[:isic].strip if item[:isic].present?
      if item[:wzcode][/^[A-Z]+$/]
        current_category = c
      else
        c.parent = current_category
      end
      c.save
    end
  end
end
