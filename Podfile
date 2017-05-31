# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'

target 'Everest_iOS' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  #Pods for Everest_iOS
  pod 'Alamofire', '~> 4.0'
  pod 'RealmSwift'
  pod 'Socket.IO-Client-Swift', '~> 10.0'
  pod 'FontAwesome.swift'

  target 'Everest_iOSTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Everest_iOSUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

#Xcode 8 RealmSwift requirement
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
