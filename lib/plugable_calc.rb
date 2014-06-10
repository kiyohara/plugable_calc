require 'plugable_calc/version'

require 'yaml'

module PlugableCalc
  def self.calc(string, proc_progress=nil)
    begin
      has_match = false

      Plugin.plugins.each do |plugin|
        if md = string.match(plugin[:matcher])
          plugin_module = Object.const_get(plugin[:module_name])
          plugin_calc = plugin_module.send(:calc, md)
          string = string.sub(plugin[:matcher], plugin_calc)

          unless proc_progress.nil?
            proc_progress.call(string)
          end

          has_match = true
          break
        end
      end
    end while has_match

    string
  end
end

Dir[File.expand_path('../plugable_calc', __FILE__) << '/*.rb'].each do |file|
  require file
end
