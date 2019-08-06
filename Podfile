source 'https://github.com/CocoaPods/Specs.git'
platform :ios, ‘10.0’
use_frameworks!

target 'Diary' do
    pod 'URLNavigator', '~> 2.2.0'
    pod 'Alamofire', '~> 4.8.2'
    pod 'MJRefresh', '~> 3.2.0'
    pod 'SnapKit', '~> 5.0.0'
    pod 'Kingfisher', '~> 5.4.0'
    pod 'Moya/RxSwift'
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'IQKeyboardManagerSwift', '~> 6.3.0'
    pod 'NSObject+Rx'
    pod 'RxDataSources'
    pod 'Moya-ObjectMapper/RxSwift'
    pod 'SVProgressHUD', '~> 2.2.5'
    pod 'FSPagerView', '~> 0.8.2'
    pod 'SwiftTheme', '~> 0.4.4'
    pod 'SwifterSwift', '~> 5.0.0'
    pod 'JXCategoryView', '~> 1.3.14'
    pod 'ZFPlayer', '~> 3.0'
    pod 'ZFPlayer/ControlView', '~> 3.0'
    pod 'ZFPlayer/AVPlayer', '~> 3.0'
    pod 'PYSearch', '~> 0.9.1'
    pod 'swiftScan', '~> 1.1.2'
    pod 'SkeletonView', '~> 1.7'
    pod 'Hero'
    pod 'pop', '~> 1.0'
end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'Diary'
            target.build_configurations.each do |config|                            
                config.build_settings['SWIFT_VERSION'] = '5'
            end
        end
    end
end
