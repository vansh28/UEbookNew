# platform :ios, '11.0'

target 'UeBook' do
      pod 'Alamofire', '~> 4.5'
      pod 'MessageKit'
      pod 'Scaledrone', '~> 0.3.0'
      pod 'Firebase/Analytics'
      pod 'Firebase/Messaging'
      pod  'IQKeyboardManagerSwift', '~> 6.0'
      pod 'JitsiMeetSDK'
      pod 'FBSDKCoreKit/Swift'
      pod 'FBSDKLoginKit/Swift'
      pod 'FBSDKShareKit/Swift'
      pod 'GoogleSignIn'
      pod 'AZTabBar'
      
      end

      post_install do |installer|
        installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
          end
        end
      end
