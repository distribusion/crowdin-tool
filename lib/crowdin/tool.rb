require "crowdin/tool/version"
require "crowdin/tool/command_handler"
require "crowdin/tool/configuration_manager"

module Crowdin
  module Tool

    CLI_COMMAND = 'crowdin-cli'

    COMMANDS = {
        'create' => [ 'upload sources', 'upload translations' ],
        'upload' => [ 'upload sources', 'upload translations' ],
        'download' => [ 'download' ]
    }

    CLI_COMMAND_DESC = {
        'create' => 'sets up the localization branch and uploads translations',
        'upload' => 'uploads translations',
        'download' => 'downloads translations'
    }

    COMMAND_DESC = CLI_COMMAND_DESC.merge(ConfigurationManager.setup_task_descriptions)

  end
end
