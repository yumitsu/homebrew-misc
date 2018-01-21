#!/usr/bin/env ruby

require 'digest'
require 'open-uri'

module BrewSHA256
  class << self
    def homebrew!
      if defined?(HOMEBREW_LIBRARY_PATH)
        require 'formula'
      else
        puts "Not running in homebrew env"
      end
    end

    def run!
      homebrew!

      query = ARGV.first
      if query === nil || query.empty?
        puts "No file, url or package specified. Exiting."
        exit(false)
      else
        data = if query.match?(/http(s)?\:\/\//)
          open(query)
        else
          if File.exist?(query)
            File.open(query)
          else
            open(package_url(query))
          end
        end

        puts Digest::SHA256.hexdigest(data.read)
      end
    end

    def load_formula(name)
      if defined?(Formula)
        Formula[name]
      else
        puts "No such package exist - '#{name}'"
        exit(1)
      end
    end

    def package_url(pkg)
      formula = load_formula(pkg)
      formula.stable.url
    end
  end
end


BrewSHA256.run!
