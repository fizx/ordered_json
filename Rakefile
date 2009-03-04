task :default => :test

task :test => :build do
  require "test/ordered_json_test"
end

task :build_clean => [:clean, :build]

task :build => "ext/Makefile" do
  system("cd ext && make")
end

file "ext/Makefile" do
  system("cd ext && ruby extconf.rb")
end

task :build_gem => :clean do
  system "gem build ordered_json.gemspec"
end

task :install => :build_gem do
  system "gem install ordered_json"
end

task :uninstall do
  system "gem uninstall -a ordered_json"
  system "gem uninstall -a fizx-ordered_json"
end

task :clean do
  rm Dir[ "ext/*.o"          ]
  rm Dir[ "ext/*.la"         ]
  rm Dir[ "ext/*.a"          ]
  rm Dir[ "ext/*.bundle"     ]
end