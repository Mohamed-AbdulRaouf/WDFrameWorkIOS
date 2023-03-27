#
# Be sure to run `pod lib lint WDFrameWorkIOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
  spec.name             = 'WDFrameWorkIOS'
  spec.version          = '1.1.8'
  spec.summary          = 'A short description of WDFrameWorkIOS.'
  

  spec.pod_target_xcconfig = { 'PRODUCT_BUNDLE_IDENTIFIER': 'com.simpletouch.wdframeWorkios' }

  spec.description      = <<-DESC
  sdsds
   sdasds
   sdsdsas
   sdasdssd
   sadsadsadsadsa adas
   adasd Assetsd sadsadsadsadsa descriptionasd
   asd
   asd
   sadsadsadsadsa sa
  DESC
  
  spec.homepage         = 'https://github.com/Mohamed-AbdulRaouf/WDFrameWorkIOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'mohamed.a.raouf@icloud.com' => 'mohamed.a.raouf@icloud.com' }
  spec.source           = { :git => 'https://github.com/Mohamed-AbdulRaouf/WDFrameWorkIOS.git', :tag => spec.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  spec.ios.deployment_target = '13.0'
  spec.swift_version    = '5.0'
#  spec.swift_versions = ['5.0', '5.1', '5.2', '5.3']
  
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
spec.source_files = 'WDFrameWorkIOS/Classes/**/*.{h,m,swift,storyboard,xib,storyboardc}'
spec.resource_bundles = {
  'resources' => 'WDFrameWorkIOS/Classes/**/*.{storyboard,xib,png,jpeg,jpg,storyboardc}'}
spec.exclude_files = "WDFrameWorkIOS/**/*.plist"


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
  spec.dependency 'Alamofire' , '~> 5.6.4'
#  spec.dependency 'SwiftyJSON', '~> 4.0'
  spec.dependency 'R.swift'
  spec.dependency 'SwifterSwift'
  spec.dependency 'CachyKit'
  spec.dependency 'TextFieldEffects'
  spec.dependency 'SideMenu'
  spec.dependency 'Firebase'
  spec.dependency 'FirebaseCore'
  spec.dependency 'FirebaseAuth'
  spec.dependency 'FirebaseMessaging'
  spec.dependency 'SwinjectStoryboard'
  spec.dependency 'Swinject'
  spec.dependency 'FSnapChatLoading'
  spec.dependency 'IQKeyboardManagerSwift'
  spec.dependency 'FontAwesome.swift'
  spec.dependency 'SVProgressHUD'
  spec.dependency 'RxSwift'
#  spec.dependency 'Toast-Swift'
  spec.dependency 'PopupDialog', '~> 1.1'
  spec.dependency 'Kingfisher', '~> 5.0'
  spec.dependency 'Cosmos'
  spec.dependency 'MyFatoorah'
  spec.dependency 'Bond'
  spec.dependency 'Localize-Swift' ,'1.7.0'
  spec.dependency 'MOLH'
  spec.dependency 'AcceptCardSDK'
  spec.dependency 'Japx'
  spec.dependency 'Japx/Codable'
#  spec.dependency 'MBProgressHUD'
#  spec.dependency 'FawryPaySDK'
#  spec.dependency 'MBRadioCheckboxButton'
#  spec.dependency 'MBRadioButton'
#  spec.dependency 'AZDialogView' not working
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
#  spec.frameworks = 'KashierPaymentSDK'
  # s.dependency 'AFNetworking', '~> 2.3'
end
