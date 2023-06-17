#
# Be sure to run `pod lib lint YMTreeMap.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YMTreeMap'
  s.version          = '1.2.0'
  s.summary          = 'A simple tree map generator for iOS and macOS.'
  s.description      = <<-DESC
YMTreeMap is a high performance treemap layout engine for iOS and macOS, written in Swift.

Tree maps (also called Heat Maps) are one or multi-dimensional graphical deprictions of
values using rectangles. The primary dimension is the area of each rectangle, which
represents the relative size of that value compared to the other values.

Another popular dimension is the treatment of inner area of the rectangles (generally
using color or shading).

Tree maps and heat maps are very popular in the financial sector, and this library
was designed for use in the Yahoo Finance iOS app.

Generating a tree-map requires nothing more than a list of positive numbers and
a rectangle to layout within.
                       DESC

  s.homepage         = 'https://github.com/yahoo/YMTreeMap'
  s.screenshots      = 'https://raw.githubusercontent.com/yahoo/YMTreeMap/master/Example/Screenshots/random30.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Adam Kaplan' => 'adamkaplan@oath.com' }
  s.source           = { :git => 'https://github.com/yahoo/YMTreeMap.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.macos.deployment_target = '10.10'
  s.swift_versions = ['4.0']

  s.source_files = 'YMTreeMap.swift'
end
