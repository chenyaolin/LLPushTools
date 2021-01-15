
Pod::Spec.new do |s|

  s.name         = 'LLPushTools' #工程的名字
  s.version      = '1.0.4' #工程的版本
  s.summary      = '摘要' #工程的摘要

  #工程的r描述, 一定要比工程的摘要要长
  s.description  = <<-DESC
  工程描述
                   DESC

  s.swift_version = "5.0"
  s.homepage     = 'https://github.com/chenyaolin/LLPushTools' #工程的首页


  s.license      = { :type => 'MIT'} #工程的证书


  s.author             = { '陈耀林' => 'lindits@163.com' }
  s.ios.deployment_target = '10.0'
  s.requires_arc = true
  s.source       = { :git => 'https://github.com/chenyaolin/LLPushTools.git', :tag => "#{s.version}" } #工程的git地址



  s.source_files  = 'LLPushTools/Public/**/*.{h,m,swift}'
  s.vendored_frameworks = 'LLPushTools.framework'
  s.dependency 'SnapKit', '~> 4.0.0'

end
