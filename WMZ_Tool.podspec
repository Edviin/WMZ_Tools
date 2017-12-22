Pod::Spec.new do |s|
s.name = 'WMZ_Tool'
s.version = '1.0.6'
s.license = 'MIT'
s.summary = 'categorys in iOS.'
s.homepage = 'https://github.com/Edviin/WMZ_Tools'
s.authors = { 'Edviin' => '353515243@qq.com' }
s.source = { :git => "https://github.com/Edviin/WMZ_Tools.git", :tag => "1.0.6"}
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = 'WMZ_Tool/WMZ_ToolDefine.h'
s.resource = "WMZ_Tool/ToolBundle.bundle"
s.frameworks = 'UIKit'
s.subspec 'Category' do |ss|
    	ss.source_files = 'WMZ_Tool/Category/*.{h,m}'
    end 
     s.subspec 'SystemHudView' do |sss|
    	sss.source_files = 'WMZ_Tool/SystemHudView/*.{h,m}'
    end  	 
end

