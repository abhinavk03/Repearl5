 platform :ios, '13.0'

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end

target 'Repearl' do
  use_frameworks!

    pod 'GoogleMaps'
    pod 'Firebase/Storage'
    pod 'Firebase/Database'
end
