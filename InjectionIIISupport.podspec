Pod::Spec.new do |s|
  s.name             = 'InjectionIIISupport'
  s.version          = '1.0.0'
  s.summary          = 'InjectionIIISupport'
  s.description      = <<-DESC
                          InjectionIIISupport
                          InjectionIIISupport
                       DESC
  s.homepage         = 'http://www.baidu.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zsh' => '1051422138@qq.com' }
  s.source           = { :git => 'https://gitee.com/githubsh/InjectionIIISupport', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.0'

  s.static_framework = true
  
  s.source_files = 'InjectionIIISupport/**/*.{h,m}'
  s.public_header_files = 'InjectionIIISupport/**.h'

end