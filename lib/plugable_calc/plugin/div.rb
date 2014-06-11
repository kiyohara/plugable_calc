module PlugableCalc
  module Plugin
    module Div
      extend Plugg::Plugin

      def self.matcher
        /([-]?\d+)\s+[\/]\s+([-]?\d+)/
      end

      def self.calc(md)
        "#{md[1].to_i / md[2].to_i}"
      end
    end
  end
end
