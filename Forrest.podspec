#
# Be sure to run `pod lib lint Forrest.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Forrest"
  s.version          = "2.0.0"
  s.summary          = "Run Shell Commands in Swift"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
- Execute any Shell Command in your Swift Scripts
- Super Easy to use
- Pipe commands easly
- < 1000 lines of code
                       DESC

  s.homepage         = "https://github.com/Gruppio/Run-Forrest-Run"
  s.screenshots     = "https://raw.github.com/Gruppio/Run-Forrest-Run/assets/RunForrestRun_(Stupid).png"
  s.license          = 'MIT'
  s.author           = { "Michele Gruppioni" => "gruppiofigo@gmail.com" }
  s.source           = { :git => "https://github.com/Gruppio/Run-Forrest-Run.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :osx, "10.9"
  s.requires_arc = true

  s.source_files = 'Sources/*'
  # s.resource_bundles = {
  #   'Forrest' => ['Pod/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
