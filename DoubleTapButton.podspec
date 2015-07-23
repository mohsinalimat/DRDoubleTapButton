Pod::Spec.new do |s|
  s.name             = "DoubleTapButton"
  s.version          = "0.1.1"
  s.summary          = "A button wich needs confirmation with two taps and gives user a feedback message"
  s.homepage         = "https://github.com/dgrueda/DRDoubleTapButton"
  s.screenshots      = ["http://diegorueda.es/code/assets/images/iOSComponents/DoubleTapButton-1.gif",
			"http://diegorueda.es/code/assets/images/iOSComponents/DoubleTapButton-2.gif",
			"http://diegorueda.es/code/assets/images/iOSComponents/DoubleTapButton-3.gif"]
  s.license          = 'MIT'
  s.author           = { "Diego Rueda" => "contacto@diegorueda.es" }
  s.source           = { :git => "https://github.com/dgrueda/DRDoubleTapButton.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/diegoruedacoach'
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'DoubleTapButton/*.swift'
end
