Pod::Spec.new do |s|
  s.name         = "MKAPopup"
  s.version      = "1.2.0"
  s.summary      = "MKAPopup is a view library."
  s.description  = <<-DESC
MKAPopup is simple and customizable popup view written in Swift for iOS.
                   DESC
  s.homepage     = "https://github.com/HituziANDO/MKAPopup"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = "Hituzi Ando"
  s.platform     = :ios, "9.3"
  s.source       = { :git => "https://github.com/HituziANDO/MKAPopup.git", :tag => "#{s.version}" }
  s.source_files  = "MKAPopup/*.{swift}"
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
  s.swift_version = "4.2"
end
