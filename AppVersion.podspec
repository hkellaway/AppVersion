Pod::Spec.new do |s|

  s.name             = "AppVersion"
  s.version          = "0.2.0"
  s.summary          = "AppVersion is a Swift μ-Library offering a structured type around iOS app versions that adhere to Semantic Versioning"
  s.description      = "AppVersion is a Swift μ-Library offering a structured type around iOS app versions that adhere to Semantic Versioning."
  s.homepage         = "https://github.com/hkellaway/AppVersion"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Harlan Kellaway" => "harlan.github@gmail.com" }
  s.source           = { :git => "https://github.com/hkellaway/AppVersion.git", :tag => s.version.to_s }
  
  s.swift_version    = "5.0"
  s.platforms        = { :ios => "13.0" }
  s.requires_arc     = true

  s.source_files     = 'Sources/AppVersion/*.{swift}'

end
