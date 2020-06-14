Pod::Spec.new do |s|
  s.name         = "ObjectiveRichFlyer"
  s.version      = "1.2.3"
  s.summary      = "The RichFlyer SDK for Objective-C"
  s.description  = <<-DESC
                      This framework is RichFlyer SDK built with Objective-C. The app built with Objective-C could embed this framework.
                   DESC
  s.homepage     = "https://richflyer.net"
  s.license      = { :type => "Commercial", :file => "LICENSE.txt" }
  s.author       = { "INFOCITY, Inc." => "richflyer@infocity.co.jp" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/INFOCITY/richflyer-sdk-objc.git", :tag => "#{s.version}" }
  s.ios.vendored_frameworks = "RichFlyer.framework"
end
