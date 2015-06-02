#
# Be sure to run `pod lib lint eWAYPaymentsSDK.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "eWAYPaymentsSDK"
  s.version          = "1.0.0-Beta1"
  s.summary          = "eWAYPaymentsSDK allows eway payment to be performed directly from any compatible iOS device."
  s.description      = "eWAYPaymentsSDK allows eway payment to be performed directly from any compatible iOS device. Below are steps needed to be done before using the SDK in your application"
  s.homepage         = "https://github.com/eWAYPayment/eWAYPaymentsSDK"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "eWAY" => "tony@eway.com.au" }
  s.source           = { :git => "https://github.com/eWAYPayment/eWAYPaymentsSDK.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'eWAYPaymentsSDK' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
