require 'plugable_calc/version'

require 'plugg'
require 'yaml'

module PlugableCalc
  class Calculator
    include Plugg

    def initialize
      plugin_dir = File.expand_path('../plugable_calc/plugin', __FILE__)
      load_plugins(plugin_dir)
    end

    def calc(string, proc_progress = nil)
      loop do
        matched = false

        plugins.each do |plugin|
          md = string.match(plugin.matcher)
          next unless md

          plugin_calc = plugin.send(:calc, md)
          string = string.sub(plugin.matcher, plugin_calc)

          proc_progress.call(string) unless proc_progress.nil?

          matched = true
        end

        break unless matched
      end

      string
    end
  end
end

Dir[File.expand_path('../plugable_calc', __FILE__) << '/*.rb'].each do |file|
  require file
end
