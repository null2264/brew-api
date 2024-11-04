#!/usr/bin/env brew ruby
#
# Copyright (c) 2009-present, Homebrew contributors. All rights reserved.
# SPDX-License-Identifier: BSD-2-Clause
#
# Simplified version of `generate-cask-api` and `generate-cask`
#
# REF: https://github.com/Homebrew/formulae.brew.sh/blob/998358b5d3d4e8710696e841d8fb195cebedd8dd/script/generate-cask.rb
# REF: https://github.com/Homebrew/brew/blob/4d0deeb68e488fd2208c8a1058c506e70b182a63/Library/Homebrew/dev-cmd/generate-cask-api.rb#L47-L63
#

require "cask/cask"

tap_name = ARGV.first
tap = Tap.fetch(tap_name)

Cask::Cask.generating_hash!

tap.cask_files.each do |path|
  cask = Cask::CaskLoader.load(path)
  name = cask.token
  json = JSON.pretty_generate(cask.to_hash_with_variations)

  IO.write("_data/cask/#{name}.json", "#{json}\n")
rescue
  onoe "Error while generating data for '#{path.stem}'"
end
