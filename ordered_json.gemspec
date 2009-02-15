Gem::Specification.new do |s|
  s.name     = "ordered_json"
  s.version  = "0.1.3"
  s.date     = "2009-02-15"
  s.summary  = "Ordered json hash conversion "
  s.email    = "kyle@kylemaxwell.com"
  s.has_rdoc = true
  s.extensions = "ext/extconf.rb"
  s.authors  = ["Kyle Maxwell"]
  s.files    = %w[
    ./ext/extconf.rb
    ./ext/ordered_json_c.c
    ./lib/ordered_json.rb
    ./ordered_json.gemspec
    ./README
    ./Rakefile
    ./test/ordered_json_test.rb
  ]
  s.add_dependency("collections", ["> 0.0.0"])
end
