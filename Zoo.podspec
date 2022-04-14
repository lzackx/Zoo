#
# Be sure to run `pod lib lint Zoo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                    = 'Zoo'
  s.version                 = '1.0.0'
  s.summary                 = 'A development tools for developer'
  s.description             = <<-DESC
  A utils for developer
                       DESC
  s.homepage                = 'https://github.com/lzackx/Zoo'
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { 'lzackx' => 'lzackx@lzackx.com' }
  s.source                  = { :git => 'https://github.com/lzackx/Zoo.git', :tag => s.version.to_s }
  s.ios.deployment_target   = '9.0'
  s.default_subspec         = 'Core'
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES'
  }

  s.subspec 'Core' do |ss|
    ss.source_files         = 'Zoo/Classes/Core/**/*.{h,m,c,mm}'
    ss.resource_bundles     = {
      'Zoo' => 'Zoo/Assets/**/*'
    }
    ss.pod_target_xcconfig  = {
      'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) ZooWithPlatform ZooWithPerformance ZooWithUI'
    }
  end

  s.subspec 'All' do |ss|
    ss.dependency             'Zoo/Core'
    ss.dependency             'Zoo/Logger'
    ss.dependency             'Zoo/GPS'
    ss.dependency             'Zoo/MemoryLeaksFinder'
  end

  s.subspec 'Logger' do |ss| 
    ss.source_files         = 'Zoo/Classes/Logger/**/*{.h,.m}'
    ss.dependency           'Zoo/Core'
    ss.dependency           'CocoaLumberjack'
    ss.pod_target_xcconfig  = {
      'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) ZooWithLogger'
    }
  end

  s.subspec 'GPS' do |ss| 
    ss.source_files         = 'Zoo/Classes/GPS/**/*{.h,.m}'
    ss.dependency           'Zoo/Core'
    ss.pod_target_xcconfig  = {
      'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) ZooWithGPS'
    }
  end

  s.subspec 'MemoryLeaksFinder' do |ss|
    ss.source_files         = 'Zoo/Classes/MLeaksFinder/**/*{.h,.m}'
    ss.dependency           'Zoo/Core'
    ss.dependency           'FBRetainCycleDetector'
    ss.pod_target_xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) ZooWithMLeaksFinder'
    }
  end

end
