require "rubygems"
require "bundler/setup"
require "releasy"

Releasy::Project.new do
  name "APP_NAME"
  version "0.1"
  verbose

  executable "play.rb"
  files ["play.rb", "lib/**/*.rb"]
  add_link "http://github.com/EddM/LD32", "GitHub"
  exclude_encoding

  add_build :osx_app do
    url "com.eddmorgan.ld32"
    wrapper "etc/wrappers/gosu-mac-wrapper-0.7.47.tar.gz"
    # icon "media/icon.icns"
    add_package :tar_gz
    add_package :dmg
  end

  # add_build :windows_standalone do
  #   executable_type :windows
  # end

  add_build :windows_wrapped do
    wrapper "etc/wrappers/ruby-1.9.3-p551-i386-mingw32.7z"
    executable_type :windows
    exclude_tcl_tk
    add_package :zip
  end

  add_deploy :local
end

task :ocra do
  cmd = [
    "ocra play.rb",
    "--add-all-core",
    "--gemfile Gemfile",
    "--no-enc",
    "--icon res/Icon.ico"
  ]

  `#{cmd.join(" ")}`
end
