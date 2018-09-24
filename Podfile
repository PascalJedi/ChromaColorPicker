source 'https://github.com/CocoaPods/Specs.git'

inhibit_all_warnings!
install! 'cocoapods', :deterministic_uuids => false

# Disable reporting of stats, so own pods don't get reported
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

# -------------------------------------------------

# Uncomment the next line to define a global platform for your project

PROJECT_NAME = 'ChromaColorPicker-Demo'
TEST_TARGET = 'ChromaColorPickerTests'
DEMO_TARGET = 'ChromaColorPicker-Demo'
SCHEME_FILE = 'ChromaColorPickerTests.xcscheme'

target TEST_TARGET do
  project PROJECT_NAME

  use_frameworks!
  platform :ios, '9.3'
  inherit! :search_paths

  # Pods for ChromaColorPicker-Demo
  pod 'EarlGrey'

  # https://github.com/SwifterSwift/SwifterSwift
  pod 'SwifterSwift'

end

# -------------------------------------------------

target DEMO_TARGET do

  use_frameworks!
  platform :ios, '9.3'
  inherit! :search_paths

  # https://github.com/SwifterSwift/SwifterSwift
  pod 'SwifterSwift'

end

# -------------------------------------------------

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'NO'
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ''
      config.build_settings['CODE_SIGNING_REQUIRED'] = 'NO'
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
      config.build_settings['ENABLE_BITCODE'] = 'YES'
      config.build_settings['SWIFT_VERSION'] = '4.2'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.3'
      if config.name == "Debug"
        config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
      else
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
      end
    end
  end

  installer.pods_project.build_configuration_list.build_configurations.each do |configuration|
    configuration.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
    configuration.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'NO'
  end

end

