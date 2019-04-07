Pod::Spec.new do |s|
  s.name         = "MKAPopupObjC"
  s.version      = "1.1.0"
  s.summary      = "MKAPopupObjC is a view library."
  s.description  = <<-DESC
MKAPopupObjC is simple and customizable popup view written in Objective-C for iOS.
                   DESC
  s.homepage     = "https://github.com/HituziANDO/MKAPopup"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Hituzi Ando" => "" }
  s.platform     = :ios, "9.3"
  s.source       = { :git => "https://github.com/HituziANDO/MKAPopup.git", :tag => "#{s.version}" }
  s.source_files  = "MKAPopupObjC/MKAPopupObjC/*.{h,m}"
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
