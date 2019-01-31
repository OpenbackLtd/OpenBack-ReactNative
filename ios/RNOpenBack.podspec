
Pod::Spec.new do |s|
  s.name          = "RNOpenBack"
  s.version       = "1.0.1"
  s.summary       = "React Native module for the iOS OpenBack SDK."
  s.description   = "React Native module for the iOS OpenBack SDK - Make every notification count."
  s.homepage      = "https://www.openback.com"
  s.documentation_url = 'https://docs.openback.com/plugins/react/'
  s.license       = { :type => 'Commercial', :file => 'LICENSE' }
  s.author        = { 'OpenBack, Ltd.' => 'info@openback.com' }
  s.platform      = :ios, "8.0"
  s.source        = { :git => "https://github.com/OpenbackLtd/OpenBack-ReactNative.git", :tag => "master" }
  s.source_files  = "RNOpenBack/**/*.{h,m}"
  s.requires_arc  = true
  
  s.dependency "React"
  s.dependency "OpenBack"

end

  