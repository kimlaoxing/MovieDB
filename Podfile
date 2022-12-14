
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!

workspace 'MovieDB'

def core_pods
pod 'Toast-Swift', '~> 5.0.1'
pod 'SwiftLint'
pod 'Declayout'
pod 'Alamofire'
end

target 'Router' do
project 'Router/Router.project'
end

target 'Favorite' do
project 'Favorite/Favorite.project'
core_pods
end

target 'Home' do
project 'Home/Home.project'
core_pods
end

target 'Profile' do
project 'Profile/Profile.project'
core_pods
end

target 'Components' do
project 'Components/Components.project'
core_pods
end

target 'SearchBar' do
project 'SearchBar/SearchBar.project'
core_pods
end

target 'MovieDB' do
project 'MovieDB.project'
core_pods
end


