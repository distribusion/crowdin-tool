module Crowdin
  module Tool
    class CommandHandler
      require 'childprocess'

      def initialize(command)
        @tasks = []
        setup_tasks = ConfigurationManager.run_setup_tasks(command)
        ConfigurationManager.configure_crowdin
        add_cli_command_tasks(command)
        if @tasks.empty? && (setup_tasks.nil? || setup_tasks.empty?)
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
        expanded_tasks.each do |cmd|
          puts "Running #{cmd}"
          task_proc = ChildProcess.build('bundle', 'exec', cmd).tap do |process|
            process.io.stdout = process.io.stderr = STDOUT
            process.cwd = Dir.pwd
          end.start
          until task_proc.exited? do
            begin
              task_proc.poll_for_exit(1)
            rescue ChildProcess::TimeoutError
            end
          end
        end
      end

      def add_cli_command_tasks(command)
        (COMMANDS[command] || []).each do |task|
          @tasks << task
        end
      end

      def expanded_tasks
        @tasks.map do |task|
          [ CLI_COMMAND, task, task_branch_argument ].compact.join(' ')
        end
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
