#
# Be sure to run `pod lib lint WDFrameWorkIOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
    spec.name             = 'WDFrameWorkIOS'
    spec.version          = '3.5.1'
    spec.summary          = 'food ordering services of WadiDegla.'
    spec.pod_target_xcconfig = { 'PRODUCT_BUNDLE_IDENTIFIER': 'com.simpletouch.wdframeWorkios' }
    
    spec.description      = <<-DESC
    --- WDFrameWork ---
    WadiDegla Framework (SDK),
    It allows you to connect to food ordering services through our
    effective, important platform at the world of restaurant management,
    WadiDegla Framework (SDK)
    --- WDFrameWork ---
    DESC
    
    spec.homepage         = 'https://github.com/Mohamed-AbdulRaouf/WDFrameWorkIOS'
    spec.license          = { :type => 'MIT', :file => 'LICENSE' }
    spec.author           = { 'mohamed.a.raouf@icloud.com' => 'mohamed.a.raouf@icloud.com' }
    spec.source           = { :git => 'https://github.com/Mohamed-AbdulRaouf/WDFrameWorkIOS.git', :tag => spec.version.to_s }
    
    spec.ios.deployment_target = '13.0'
    spec.swift_version  = '5.3.2'
    spec.static_framework = true
    spec.requires_arc = true
    spec.pod_target_xcconfig = { 'VALID_ARCHS' => 'arm64 arm64e armv7 armv7s x86_64' }
    spec.source_files = 'WDFrameWorkIOS/Classes/**/*.{h,m,swift,storyboard,xib,storyboardc,xcframework,framework,strings,otf}'
    spec.resource_bundles = {
        'resources' => 'WDFrameWorkIOS/Classes/**/*.{h,m,swift,storyboard,xib,png,jpeg,jpg,storyboardc,xcframework,framework,strings,otf}'}
    spec.exclude_files = "WDFrameWorkIOS/**/*.plist"
    spec.dependency 'GoogleMaps'
    spec.dependency 'GooglePlaces'
    spec.dependency 'Alamofire' , '~> 5.6.4'
    spec.dependency 'R.swift', '~> 7.2.4'
    spec.dependency 'SwifterSwift', '~> 6.2.0'
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
    spec.dependency 'IQKeyboardManagerSwift', '~> 8.0.0'
    spec.dependency 'FontAwesome.swift'
    spec.dependency 'SVProgressHUD'
    spec.dependency 'RxSwift'
    spec.dependency 'PopupDialog', '~> 1.1'
    spec.dependency 'Kingfisher', '~> 5.0'
    spec.dependency 'Cosmos'
    spec.dependency 'Bond'
    spec.dependency 'Localize-Swift' ,'1.7.0'
    spec.dependency 'MOLH'
    spec.dependency 'Japx'
    spec.dependency 'Japx/Codable'
    spec.dependency 'AcceptCardSDK' , '5.6.0'
end
