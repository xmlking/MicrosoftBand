Pod::Spec.new do |s|
  s.name             = 'MicrosoftBand'
  s.version          = '0.1.3'
  s.summary          = 'MicrosoftBand Pod for IoT Porjects.'
  s.description      = <<-DESC
                        Swift wrapper for MicrosoftBand SDK, to use it with NativeScript plugins.
                       DESC
  s.homepage         = 'https://github.com/xmlking/MicrosoftBand'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sumanth Chinthagunta' => 'xmlking+github@gmail.com' }
  s.source           = { :git => 'https://github.com/xmlking/MicrosoftBand.git', :tag => s.version }
  s.social_media_url = 'https://twitter.com/xmlking'
  s.ios.deployment_target = '8.0'
  s.ios.vendored_frameworks = 'MicrosoftBandKit_iOS.framework'
  s.source_files = 'MicrosoftBand/**/*'
  s.requires_arc = true
  s.pod_target_xcconfig = {'SWIFT_VERSION' => '3.1'}
end
