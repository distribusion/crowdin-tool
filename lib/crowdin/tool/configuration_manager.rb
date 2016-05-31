module Crowdin
  module Tool
    class ConfigurationManager
      require 'yaml'

      SETUP_COMMAND_DESC = {
          'init' => 'initializes crowdin-cli configuration for the current project'
      }

      def self.setup_task_descriptions
        SETUP_COMMAND_DESC
      end

      def self.setup_commands
        SETUP_COMMAND_DESC.keys
      end

      def self.run_setup_tasks(commands)
        (self.setup_commands & [commands].flatten).each do |task|
          self.send(task)
        end
      end

      def self.configure_crowdin
        init unless File.exist?(configuration_filename)
      end

      def self.init
        configuration = default_configuration
        raise "Cannot load default configuration" unless configuration.is_a?(Hash)
        configuration['base_path'] = Dir.pwd
        save_configuration(configuration)
      end

      def self.save_configuration(configuration)
        puts "Writing crowdin configuration to '#{configuration_filename}'"
        File.open(configuration_filename, 'w+') do |file|
          file << YAML::dump(configuration)
        end
      end

      def self.default_configuration
        YAML::load_file(default_configuration_filename)
      rescue Exception => e
        raise "Unable to read default configuration from '#{default_configuration_filename}'"
      end

      def self.default_configuration_filename
        'crowdin_default.yaml'
      end

      def self.configuration_filename
        'crowdin.yaml'
      end

    end
  end
end
