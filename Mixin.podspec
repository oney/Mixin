Pod::Spec.new do |s|
  s.name             = 'Mixin'
  s.version          = '0.1.1'
  s.summary          = 'Mixins for iOS projects'
  s.description      = <<-DESC
Add React.js-like mixins to your iOS projects
                       DESC

  s.homepage         = 'https://github.com/oney/Mixin'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Howard Yang' => 'appdevoney@gmail.com' }
  s.source           = { :git => 'https://github.com/oney/Mixin.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Mixin/Classes/**/*'
end
