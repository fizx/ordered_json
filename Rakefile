task :default => :test

task :test do
  require "test/ordered_json_test"
end

task :build_clean => [:clean, :build]

task :build do
  if system("cd ext && make")
    puts "-" * 78
    puts "success"
    puts
    exit 0
  end
  exit 1
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