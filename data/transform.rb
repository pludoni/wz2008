require 'pry'
headlines = [:lfdnr, :wzcode, :bezeichnung, :isic]
couples = File.read('data/original.tsv').lines.map{|l|
  t = l.split("\t")
  t.pop
  Hash[headlines.zip(t)]
}
current_category = nil
couples.each do |abschnitt|
  if abschnitt[:wzcode][/^[A-Z]+$/]
    current_category = abschnitt[:wzcode]
  end
  abschnitt[:category] = current_category
end

