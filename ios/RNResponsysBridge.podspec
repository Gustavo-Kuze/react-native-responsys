
Pod::Spec.new do |s|
  s.name         = "RNResponsysBridge"
  s.version      = "1.0.0"
  s.summary      = "RNResponsysBridge"
  s.description  = <<-DESC
                  RNResponsysBridge
                   DESC
  s.homepage     = "https://github.com/juntossomosmais/react-native-responsys"
  s.license      = "MIT"
  s.author       = { "author" => "author@domain.cn" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/juntossomosmais/react-native-responsys.git" }
  s.source_files = "*.{h,m}"
  s.requires_arc = true

  s.vendored_frameworks = "PushIOManager.framework"
  s.dependency "React"

end
