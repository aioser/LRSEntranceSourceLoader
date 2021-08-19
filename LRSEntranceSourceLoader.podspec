#
# Be sure to run `pod lib lint LRSEntranceSourceLoader.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LRSEntranceSourceLoader'
  s.version          = '0.1.5'
  s.summary          = 'A short description of LRSEntranceSourceLoader.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
游戏启动资源加载
                       DESC

  s.homepage         = 'https://github.com/刘sama/LRSEntranceSourceLoader'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '刘sama' => 'junchen.liu@jiamiantech.com' }
  s.source           = { :git => 'https://github.com/aioser/LRSEntranceSourceLoader.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  # s.resource_bundles = {
  #   'LRSEntranceSourceLoader' => ['LRSEntranceSourceLoader/Assets/*.png']
  # }
  s.subspec 'Mask' do |mask|
    mask.source_files = 'LRSEntranceSourceLoader/Classes/Mask/**/*'
  end
  s.subspec 'Animation' do |animation|
    animation.source_files = 'LRSEntranceSourceLoader/Classes/Animation/**/*'
    animation.dependency 'LRSEntranceSourceLoader/Mask'
  end
  s.subspec 'Extern' do |extern|
      extern.source_files = 'LRSEntranceSourceLoader/Classes/Extern/**/*'
      extern.dependency 'SDWebImage', '~> 5.0'
  end
  s.subspec 'Loader' do |loader|
    loader.source_files = 'LRSEntranceSourceLoader/Classes/Loader/**/*'
    loader.resource_bundles = {
      'LRSEntranceSourceLoader' => ['LRSEntranceSourceLoader/Assets/*']
    }
    loader.dependency 'SDWebImage', '~> 5.0'
    loader.dependency 'Masonry', '~> 1.1.0'
    loader.dependency 'BlocksKit/Core', '~> 2.2.5'
    loader.dependency 'LRSEntranceSourceLoader/Animation'
    loader.dependency 'LRSEntranceSourceLoader/Extern'
    loader.dependency  'JSONModel', '~> 1.7.0'
  end
end
