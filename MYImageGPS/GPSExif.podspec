Pod::Spec.new do |s|

s.name         = "GPSExif"
s.version      = "0.0.1"
s.summary      = "photo GPSExif for ios."
s.homepage     = "https://github.com/wangit/MYImageGPS"
s.license      = "MIT"
s.author             = { "wxz" => "wxz@lifesea.com" }
s.platform     = :ios, "7.0"
s.source       = { :git => "https://github.com/wangit/MYImageGPS.git", :tag => "#{s.version}" }
s.source_files  = "GPSExif", "GPSExif/**/*.{h,m}"
s.framework  = "UIKit"
# s.frameworks = "SomeFramework", "AnotherFramework"

end
