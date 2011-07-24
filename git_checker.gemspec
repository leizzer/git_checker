# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "git_checker/version"

Gem::Specification.new do |s|
  s.name        = "git_checker"
  s.version     = GitChecker::VERSION
  s.authors     = ["leizzer"]
  s.email       = ["lizzydw@gmail.com"]
  s.homepage    = "https://github.com/leizzer/git_checker"
  s.summary     = %q{Keep an eye on your git repository}
  s.description = %q{Using git_checker you can make scrips for perform checks over your git repositories easily	}

  s.rubyforge_project = "git_checker"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
