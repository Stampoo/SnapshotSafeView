Pod::Spec.new do |s|

  s.name = "SnapshotSafeView"
  s.version = "0.2.0"
  s.summary = "Used for hide view from system screenshots and video recording."
  s.description  = "Used for hide view from system screenshots and video recording."

  s.homepage  = "https://github.com/Stampoo/SnapshotSafeView"
  s.license  = { :type => "MIT", :file => "LICENSE" }
  s.author  = { "Ilya Knyazkov" => "fivecoil@gmail.com" }
  s.source = { :git => "https://github.com/surfstudio/ios-utils.git", :tag => "#{s.version}" }
  s.source_files = 'Sources/**/*'
  s.ios.deployment_target = '12.0'
  s.swift_version = '5.5'

end