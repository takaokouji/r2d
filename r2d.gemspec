$:.push File.expand_path('../lib', __FILE__)
require 'r2d/version'

Gem::Specification.new do |s|
  s.name        = 'r2d-takaokouji'
  s.version     = R2D::VERSION
  s.date        = '2013-07-25'
  s.author      = 'Kouji Takao'
  s.email       = 'kouji.takao@gmail.com'
  s.summary     = 'R2D by Kouji Takao'
  s.description = 'R2D original: https://github.com/blacktm/r2d. This is temporary gem.'
  s.homepage    = 'https://github.com/takaokouji/r2d'
  s.license     = 'MIT'
  s.files       = Dir.glob('lib/**/*')
  s.add_dependency 'gosu', '~> 0.7.47.1'
  s.required_ruby_version = '>= 1.9.3'
  s.executables << 'r2d'
end
