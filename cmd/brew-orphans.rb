#!/usr/bin/env ruby

module BrewOrphans
  class << self
    def run!
      homebrew!

      brew_list_installed, orphaned_pkgs = %x`brew list`.strip.split("\n"), []

      unless (brew_list_installed.nil? || brew_list_installed.empty?)
        brew_list_installed.each do |pkg|
          begin
            f = Formula[pkg]
          rescue
            orphaned_pkgs.push(pkg)
          end
        end
        return if orphaned_pkgs.empty?
        puts Formatter.columns(orphaned_pkgs)
      else
        puts "No packages installed, exiting."
        exit(1)
      end

    end

    def homebrew!
      if defined?(HOMEBREW_LIBRARY_PATH)
        require 'formula'
      else
        puts "Not running in homebrew env"
        exit(1)
      end
    end
  end
end

BrewOrphans.run!
