platform :ios, '11.0'
use_frameworks!

target 'Weather' do
    pod 'Moya'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if ['Moya'].include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.2'
            end
        end
    end
end
