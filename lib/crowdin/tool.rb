require "crowdin/tool/version"
require "crowdin/tool/command_handler"

module Crowdin
  module Tool

    CLI_COMMAND = 'crowdin-cli'

    COMMANDS = {
        'init' => [ 'upload sources', 'upload translations' ],
        'upload' => [ 'upload translations' ],
        'download' => [ 'download' ]
    }

    COMMAND_DESC = {
        'init' => 'sets up the localization branch and uploads translations',
        'upload' => 'uploads translations',
        'download' => 'downloads translations'
    }

  end
end
