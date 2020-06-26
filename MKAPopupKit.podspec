Pod::Spec.new do |s|
  s.name         = "MKAPopupKit"
  s.version      = "3.0.0"
  s.summary      = "Simple and customizable popup view."
  s.description  = <<-DESC
MKAPopupKit is simple and customizable popup view for iOS.
                   DESC
  s.homepage     = "https://github.com/HituziANDO/MKAPopupKit"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = "Hituzi Ando"
  s.platform     = :ios, "9.3"
  s.source       = { :git => "https://github.com/HituziANDO/MKAPopupKit.git", :tag => "#{s.version}" }
  s.source_files = "MKAPopupKit/*.{h,m}"
  #s.exclude_files = ""
  # s.public_header_files = "Classes/**/*.h"
  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  s.requires_arc = true
  #s.swift_version = "4.2"
end
