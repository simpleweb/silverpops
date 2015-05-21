Gem::Specification.new do |s|
  s.name        = 'Silverpops'
  s.version     = '0.1.1'
  s.date        = '2015-02-22'
  s.summary     = "Silverpops is a clunky campaign manager"
  s.description = "Some basic cheetah mail API end points implemented"
  s.authors     = ["Tom Holder"]
  s.email       = 'tom@simpleweb.co.uk'
  s.files       = Dir["{lib}/**/*", "Gemfile"]
  s.homepage    =
    'http://rubygems.org/gems/silverpops'
  s.license       = 'MIT'
  s.add_dependency "nokogiri", ["~> 1.6.6.2"]
  s.add_dependency "faraday",["~> 0.9.1"]
  s.add_dependency "redis", ["~> 3.0.1"]
end
