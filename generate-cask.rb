#!/usr/bin/env brew ruby
require "cask/cask"

tap_name = ARGV.first
tap = Tap.fetch(tap_name)

tap.cask_files.each do |path|
  cask = Cask::CaskLoader.load(path)
  name = cask.token
  json = JSON.pretty_generate(cask.to_hash_with_variations)

  IO.write("_data/cask/#{name}.json", "#{json}\n")
rescue
  onoe "Error while generating data for '#{path.stem}'"
end
