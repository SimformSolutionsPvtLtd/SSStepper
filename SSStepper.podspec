
#
# Be sure to run `pod lib lint SSStepper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'SSStepper'
    s.version          = '1.0.1'
    s.summary          = 'SSStepper is a custom stepper with gesture controls and flexible design as per your choice.'

    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
    'It supports stepper operation by swiping. By swiping up user can directly shift to maximum value that you have set. By swiping down user can directly shif to minimum value that you have set. And by swiping left and right user can increse or decrease the value by count that you have set. It is fully customisable by Shapes of backgorund view and top view alogn with colors, Directions, haptic feedbacks, colors of icons and Text, axis of stepper whether you want vertical or Horizontal.'
    DESC

    s.homepage         = 'https://github.com/mobile-simformsolutions/SSStepper'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Shubham Vyas' => 'shubham.vyas@simformsolutions.com' }
    s.source           = { :git => 'https://github.com/mobile-simformsolutions/SSStepper.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '13.0'

    s.source_files = '**/Sources/SSStepper/**/*'
    s.swift_version = '5.0'

    # s.resource_bundles = {
    #   'SSStepper' => ['SSStepper/Assets/*.png']
    # }

    # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit', 'MapKit', 'SwiftUI'
    # s.dependency 'AFNetworking', '~> 2.3'
end
