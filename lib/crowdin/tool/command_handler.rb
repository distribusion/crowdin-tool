module Crowdin
  module Tool
    class CommandHandler
      def initialize(command)
        @tasks = []
        case command
          when 'init'
            add_upload_sources_task
            add_upload_translations_task
          when 'upload'
            add_upload_translations_task
          when 'download'
            add_download_task
          else
            puts "Usage:"
            puts "translate [command]"
            puts "\nCommands:"
            puts " init     : sets up the localization branch and uploads translations"
            puts " upload   : uploads translations"
            puts " download : downloads translations"
            puts
        end
      rescue Exception => e
        puts "Aborting due to #{e.class.name}: #{e.message}"
      end

      def execute
        `#{expand_tasks}` unless @tasks.empty?
      end

      def expand_tasks
        @tasks.map do |task|
          [ 'bundle exec', cli_executable, task, task_branch_argument ].compact.join(' ')
        end.join(' && ')
      end

      def add_upload_sources_task
        @tasks << 'upload sources'
      end

      def add_upload_translations_task
        @tasks << 'upload translations'
      end

      def add_download_task
        @tasks << 'download'
      end

      def task_branch_argument
        if current_branch == 'master'
          nil
        else
          "-b #{current_branch}"
        end
      end

      def cli_executable
        'crowdin-cli'
      end

      def current_branch
        `git rev-parse --abbrev-ref HEAD`.strip
      end
    end
  end
end
