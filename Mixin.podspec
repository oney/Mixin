#
# Be sure to run `pod lib lint Mixin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Mixin'
  s.version          = '0.1.0'
  s.summary          = 'Mixins for iOS projects'
  s.description      = <<-DESC
Add React.js-like mixins to your iOS projects
                       DESC

  s.homepage         = 'https://github.com/oney/Mixin'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Howard Yang' => 'appdevoney@gmail.com' }
  s.source           = { :git => 'https://github.com/oney/Mixin.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Mixin/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Mixin' => ['Mixin/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
end
