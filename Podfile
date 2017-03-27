# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target 'FortgroupTest' do
  use_frameworks!
  
  # Mobile DB
  pod 'RealmSwift', '2.4.4'
  
  # Networking
  pod 'Alamofire', '4.3.0'
  pod 'AlamofireImage'
  
  # Mapper serialization
  pod 'ObjectMapper', '2.2.5'
  
  target 'FortgroupTestTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0.2'
    end
  end
end
