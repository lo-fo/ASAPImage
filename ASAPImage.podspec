Pod::Spec.new do |s|
  s.name             = 'ASAPImage'
  s.version          = '0.1.4'
  s.summary          = 'Asynchronous image downloading utilities'
 
  s.description      = <<-DESC
A library providing asynchronous image downloading utilities.
                       DESC
 
  s.homepage         = 'https://github.com/lo-fo/ASAPImage'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Louis Fournier' => 'louis.fo@gmail.com' }
  s.source           = { :git => 'https://github.com/lo-fo/ASAPImage.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'ASAPImage/ASAPImage*.swift', 'ASAPImage/Async/*.swift', 'ASAPImage/Utilities/*.swift'
 
end