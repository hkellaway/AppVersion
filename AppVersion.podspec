Pod::Spec.new do |s|

  s.name             = "AppVersion"
  s.version          = "0.2.0"
  s.summary          = "A Swift μ-Library for determining app version"
  s.description      = "A Swift μ-Library for determining app version."
  s.homepage         = "https://github.com/hkellaway/AppVersion"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Harlan Kellaway" => "harlan.github@gmail.com" }
  s.source           = { :git => "https://github.com/hkellaway/AppVersion.git", :tag => s.version.to_s }
  
  s.swift_version    = "5.0"
  s.platforms        = { :ios => "13.0" }
  s.requires_arc     = true

  s.source_files     = 'Sources/*.{swift}'

end
