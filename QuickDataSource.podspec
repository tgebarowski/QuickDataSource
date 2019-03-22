Pod::Spec.new do |s|
  s.name = 'QuickDataSource'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'μFramework for writing testable Data Sources and ViewModels for UITableView and UICollectionView.'
  s.homepage = 'https://github.com/tgebarowski/QuickDataSource'
  s.social_media_url = 'https://twitter.com/tgebarowski'
  s.authors = { 'Tomasz Gebarowski' => 'gebarowski@gmail.com' }
  s.source = { :git => 'https://github.com/tgebarowski/QuickDataSource.git', :tag => s.version }
  s.ios.deployment_target = '10.0'
  s.source_files = 'Sources/**/*.swift'
  s.requires_arc = true
  s.swift_version = '4.2'
end
