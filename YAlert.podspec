Pod::Spec.new do |s|
  s.name             = 'YAlert'
  s.version          = '0.2.0'
  s.summary          = 'A customized alert view controller'
  s.description      = 'A customized alert view controller featuring the ability to specify banner image, title, message, and two user actions.'
  s.homepage         = 'https://github.com/wleofeng/YAlert'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Leo Feng' => 'wleofeng@gmail.com' }
  s.source           = { :git => 'https://github.com/wleofeng/YAlert.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'YAlert/Classes/**/*'
end
