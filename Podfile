# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

use_frameworks!

target 'DirionMova' do
  pod 'Moya'
  pod 'netfox'
  pod 'Kingfisher'
  pod 'FirebaseAnalytics'
  pod 'Firebase/Crashlytics'
  pod 'KeychainSwift', '~> 19.0'
  pod 'RealmSwift', '~> 10.33'
end


post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
  end
 end
end