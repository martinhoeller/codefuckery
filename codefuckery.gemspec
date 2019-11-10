# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'codefuckery/version'

Gem::Specification.new do |s|
    s.name        = 'codefuckery'
    s.version     = Codefuckery::VERSION
    s.date        = '2019-11-09'
    s.summary     = 'Measure how fucked-up your code is'
    s.description = 'Counts the occurrences of swearwords in your code.'
    s.authors     = ['Martin Höller']
    s.email       = 'martin@martinhoeller.net'
    s.homepage    = 'https://github.com/martinhoeller/codefuckery'
    s.license     = 'MIT'

    s.files       = `git ls-files -z`.split("\x0").reject { |f|
        f.match(%r{^(test|spec|features)/})
    }
    s.require_paths = ['lib']
    s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
end