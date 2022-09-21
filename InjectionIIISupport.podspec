Pod::Spec.new do |s|
  s.name             = 'InjectionIIISupport'
  s.version          = '1.2.3'
  s.summary          = 'InjectionIIISupport is a tool for InjectionIII'
  s.description      = <<-DESC
                          You can download the macOS app InjectionIII from the macOS AppStore,
                          use this tool by pod,
                          No need to write any code,
                          Happy to enjoy the hot reload to dynamic develop UI.
                          DESC
  s.homepage         = 'https://github.com/githubsh/InjectionIIISupport'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zsh' => '1051422138@qq.com' }
  # s.source           = { :git => 'https://gitee.com/githubsh/InjectionIIISupport.git', :tag => s.version.to_s }
  s.source           = { :git => 'https://github.com/githubsh/InjectionIIISupport.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.0'
  
  s.static_framework = true
  
  s.source_files = 'InjectionIIISupport/**/*.{h,m}'
  s.public_header_files = 'InjectionIIISupport/**.h'

end
