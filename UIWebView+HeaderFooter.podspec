Pod::Spec.new do |s|
  s.name             = "UIWebView+HeaderFooter"
  s.version          = "0.1.1"             
  s.summary          = "A category of UIWebView with headerView and footerView"    
  s.description      = <<-DESC
                       A category of UIWebView with headerView and footerView
                       DESC
  s.homepage         = "https://github.com/TonyJR/UIWebView-HeaderFooter" 
  s.license 	      = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Tony.JR" => "show_3@163.com" }
  s.source           = { :git => "https://github.com/TonyJR/UIWebView-HeaderFooter.git", :tag => "#{s.version}" }       
  s.platform         = :ios, '7.0'           
  s.requires_arc     = true               
  s.source_files     = 'UIWebView+HeaderFooter/UIWebView+HeaderFooter.{h,m}' 
  s.public_header_files = 'UIWebView+HeaderFooter/UIWebView+HeaderFooter.h'
  s.frameworks       = 'UIKit'

end