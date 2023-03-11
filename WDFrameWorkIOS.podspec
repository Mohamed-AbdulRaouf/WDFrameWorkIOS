#
# Be sure to run `pod lib lint WDFrameWorkIOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
  spec.name             = 'WDFrameWorkIOS'
  spec.version          = '0.1.0'
  spec.summary          = 'A short description of WDFrameWorkIOS.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
#  spec.info_plist = {
#    'CFBundleIdentifier' => 'com.simpletouch.WDFrameWorkIOS'
#  }


#  spec.info_plist = { 'CFBundleIdentifier' => 'com.myorg.mylib' }
  spec.pod_target_xcconfig = { 'PRODUCT_BUNDLE_IDENTIFIER': 'com.myorg.mylib' }


#  spec.pod_target_xcconfig = {
#    'PRODUCT_BUNDLE_IDENTIFIER' => '${PODS_TARGET_SRCROOT}/Resources/YourPod-Info.plist'
#  }
  spec.description      = <<-DESC
  TODO: Add long description of the pod here.
  DESC
  
  spec.homepage         = 'https://github.com/mohamed.a.raouf@icloud.com/WDFrameWorkIOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'mohamed.a.raouf@icloud.com' => 'mohamed.a.raouf@icloud.com' }
  spec.source           = { :git => 'https://github.com/mohamed.a.raouf@icloud.com/WDFrameWorkIOS.git', :tag => spec.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  spec.ios.deployment_target = '13.0'
  
#  spec.source_files = 'WDFrameWorkIOS/Classes/**/*'
#  spec.resource_bundles = {
#    'StoryboardAssets' => ['WDFrameWorkIOS/Classes/*.{storyboard,png,swift}']
#  }
  
#  spec.source_files = 'WDFrameWorkIOS/Classes/**/*'
#  spec.resource_bundles = {
#     'WDFrameWorkIOS' => ['WDFrameWorkIOS/Assets/*.{lproj,storyboard}']
#   }

#spec.source_files = 'WDFrameWorkIOS/Classes/**/*'
#spec.resource_bundles = {
#  'WDFrameWorkIOS' => ['WDFrameWorkIOS/Assets/*.{lproj,storyboard,swift}']
#}
spec.static_framework = true
spec.requires_arc = true

#spec.resources = "WDFrameWorkIOS/Classes/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
spec.source_files = 'WDFrameWorkIOS/Classes/**/*'
spec.resource_bundles = {
  'resources' => 'WDFrameWorkIOS/**/*.{lproj,storyboard,xib,png,jpeg,jpg}'}


#
#spec.source_files = 'WDFrameWorkIOS/Classes/**/*'
# 
# spec.resource_bundles = {
#    'WDFrameWorkIOS' => ['WDFrameWorkIOS/Classes/**/*.{storyboard,xib,xcdatamodeld,png,jpeg,jpg}']
# }


#spec.source_files = 'WDFrameWorkIOS/Classes/**/*'
#spec.resource_bundles = {
#  'resources' => 'WDFrameWorkIOS/**/*.{lproj,storyboard,xib,png,NIB}'}




#spec.resource_bundles = {
#  'resources' => ['WDFrameWorkIOS/**/*.{lproj,storyboard,swift}']}


#spec.source_files = 'WDFrameWorkIOS/**/*.{h,m,swift}'
#spec.resource_bundle = { 'WDFrameWorkIOS' => [ 'WDFrameWorkIOSBundle/**/*.{png,storyboard,lproj}' ] }
#  'WDFrameWorkIOS' => ['WDFrameWorkIOS/Classes/*.storyboard']
  
#spec.source_files = 'WDFrameWorkIOS/Classes/**/*'
#spec.resource_bundle = { 'WDFrameWorkIOS-Example' => [ 'Pod/Assets/*.{png,storyboard,lproj}' ] }
  
#  spec.resource = 'WDFrameWorkIOS/Classes/*.storyboard'


#  spec.resource_bundles      = {
#      "WDFrameWorkIOS" => ['WDFrameWorkIOS/Classes/TestStoryboard.storyboard']
#      }
  
  #  spec.resource_bundles = {
  #    'Resources' => ['WDFrameWorkIOS/Assets/Contents.json']
  #  }
  spec.dependency 'GoogleMaps'
  spec.dependency 'GooglePlaces'
  spec.dependency 'Alamofire' , '~> 4.7'
  spec.dependency 'SwiftyJSON', '~> 4.0'
  spec.dependency 'R.swift'
  spec.dependency 'SwifterSwift'
  spec.dependency 'CachyKit'
  spec.dependency 'TextFieldEffects'
  spec.dependency 'SideMenu', '~> 5.0.3'
  spec.dependency 'Firebase'
  spec.dependency 'FirebaseCore'
  spec.dependency 'FirebaseAuth'
  spec.dependency 'FirebaseMessaging'
  spec.dependency 'SwinjectStoryboard' , '~> 2.2.2'
  spec.dependency 'FSnapChatLoading'
  spec.dependency 'IQKeyboardManagerSwift'
  spec.dependency 'FontAwesome.swift'
  spec.dependency 'SVProgressHUD'
  spec.dependency 'RxSwift', '~> 5.1.0'
  spec.dependency 'Toast-Swift', '~> 5.0.0'
  spec.dependency 'PopupDialog', '~> 1.1'
  spec.dependency 'Kingfisher', '~> 5.0'
  spec.dependency 'Cosmos'
  spec.dependency 'MyFatoorah'
  spec.dependency 'Bond'
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
