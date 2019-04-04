source 'https://github.com/CocoaPods/Specs.git'
platform :ios, ‘10.0’
use_frameworks!

target 'Diary' do
    pod 'URLNavigator'
    pod 'Alamofire'
    pod 'MJRefresh'
    pod 'SnapKit'
    pod 'Kingfisher'
    pod 'Moya/RxSwift'
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'IQKeyboardManagerSwift'
    pod 'NSObject+Rx'
    pod 'RxDataSources'
    pod 'Moya-ObjectMapper/RxSwift'
    pod 'RealmSwift'
    pod 'SVProgressHUD'
    pod 'ESTabBarController-swift'
    pod 'FSPagerView'
    pod 'pop'
    pod 'SwiftTheme'
    pod 'SwifterSwift'
    pod 'JXCategoryView'
    pod 'ZFPlayer', '~> 3.0'
    pod 'ZFPlayer/ControlView', '~> 3.0'
    pod 'ZFPlayer/AVPlayer', '~> 3.0'
end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'Diary'
            target.build_configurations.each do |config|                            
                config.build_settings['SWIFT_VERSION'] = '4.2'
            end
        end
    end
end
