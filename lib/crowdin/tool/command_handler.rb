module Crowdin
  module Tool
    class CommandHandler

      def initialize(command)
        @tasks = []
        add_command_tasks(command)
        if @tasks.empty?
          puts "Usage:"
          puts "translate [command]"
          puts "\nCommands:"
          COMMAND_DESC.each_pair do |cmd, desc|
            puts " #{cmd.ljust(8)} : #{desc}"
          end
          puts
        end
      rescue Exception => e
        puts "Aborting due to #{e.class.name}: #{e.message}"
      end

      def execute
        `#{expand_tasks}` unless @tasks.empty?
      end

      def add_command_tasks(command)
        (COMMANDS[command] || []).each do |task|
          @tasks << task
        end
      end

      def expand_tasks
        @tasks.map do |task|
          [ 'bundle exec', CLI_COMMAND, task, task_branch_argument ].compact.join(' ')
        end.join(' && ')
      end

      def task_branch_argument
        if current_branch == 'master'
          nil
        else
          "-b #{current_branch}"
        end
      end

      def current_branch
        @branch ||= `git rev-parse --abbrev-ref HEAD`.strip
      end
    end
  end
end
