source 'https://github.com/CocoaPods/Specs.git'

workspace 'Tamago.xcworkspace'
platform :ios, '9.0'
use_frameworks!

def shared_pods
	pod 'pop', '~> 1.0'
	pod 'MBProgressHUD'
	pod 'Reachability'
	pod 'Firebase/Core'
	pod 'Firebase/Auth'
	pod 'Firebase/Database'
	pod 'Starscream'
end

project 'Tamago.xcodeproj'

target "Tamago" do 
	project 'Tamago'
	shared_pods
end

target "TamagoTests" do
	project 'Tamago'
	shared_pods
end
