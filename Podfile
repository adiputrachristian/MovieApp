platform :ios, '11.0'

workspace 'App.xcworkspace'

def common_pods
  pod 'Kingfisher', '6.3.1'
  pod 'Moya', '15.0'
  pod 'SkeletonView', '1.30.4'
  pod 'SnapKit', '5.6.0'
  pod 'RealmSwift'
  pod 'IGListKit', '~> 4.0.0'
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
  pod "youtube-ios-player-helper", "~> 1.0.4"
end

def testing_pods
  pod 'Quick'
  pod 'Nimble'
end

target 'MainApp' do
  use_frameworks!
  use_modular_headers!
  project 'MainApp/MainApp.xcodeproj'
  common_pods

  target 'MainAppTests' do
    inherit! :search_paths

    common_pods
    testing_pods
  end

  target 'MainAppUITests' do
    inherit! :search_paths

    common_pods
    testing_pods
  end
end

target 'DesignKit' do
  use_frameworks!
  use_modular_headers!
  project 'DesignKit/DesignKit.xcodeproj'
  common_pods

  target 'DesignKitTests' do
    inherit! :search_paths
    common_pods
    testing_pods
  end

end

target 'NetworkKit' do
  use_frameworks!
  use_modular_headers!
  project 'NetworkKit/NetworkKit.xcodeproj'
  common_pods

  target 'NetworkKitTests' do
    inherit! :search_paths

    common_pods
    testing_pods
  end

end

target 'MovieApp' do
  use_frameworks!
  use_modular_headers!
  project 'MovieApp/MovieApp.xcodeproj'
  common_pods

  target 'MovieAppTests' do
    inherit! :search_paths

    common_pods
    testing_pods
  end

end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'
        end
    end
end
