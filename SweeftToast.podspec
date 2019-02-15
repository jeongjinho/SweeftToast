Pod::Spec.new do |s|
  s.name             = 'SweeftToast'
  s.version          = '0.0.1'
  s.summary          = 'Simple Toast View.'
  s.description      = <<-DESC
ToastView is android style alert
                       DESC
  s.homepage         = 'https://github.com/jeongjinho/SweeftToast'
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jeongjinho' => 'yyyqor@gmail.com' }
  s.source           = { :git => 'https://github.com/jeongjinho/SweeftToast.git', :tag => s.version.to_s }
  s.requires_arc = true
  s.swift_version = '4.2'
  s.ios.deployment_target = '9.0'
  s.source_files = 'Sources/*.swift'
end