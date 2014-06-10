module PlugableCalc
  module Plugin
    def self.register(plugin_module)
      @@plugins ||= []
      @@plugins.push({
        module_name: plugin_module.to_s,
        matcher: plugin_module.matcher,
      })
    end

    def self.plugins
      @@plugins ||= []
    end
  end
end

plugin_dir = File.expand_path('../plugin', __FILE__)
plugin_yml = Pathname("#{plugin_dir}/plugins.yml")
plugin_conf = YAML.load_file(plugin_yml)
if plugin_conf['plugins'] && plugin_conf['plugins']['enable']
  plugin_conf['plugins']['enable'].each do |plugin_name|
    require Pathname("#{plugin_dir}/#{plugin_name}")
  end
end
