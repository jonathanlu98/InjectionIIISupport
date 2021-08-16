Pod::Spec.new do |s|
  s.name             = 'ExampleLib'
  s.version          = '1.0.0'
  s.summary          = 'ExampleLib'
  s.description      = <<-DESC
                          ExampleLib.
                          ExampleLib.
                          DESC
  s.homepage         = 'https://github.com/githubsh/ExampleLib'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zsh' => '1051422138@qq.com' }
  s.source           = { :git => 'https://github.com/githubsh/ExampleLib.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.0'
  
  s.static_framework = true
  
  s.source_files = 'ExampleLib/**/*.{h,m}'
  s.public_header_files = 'ExampleLib/**.h'

end
