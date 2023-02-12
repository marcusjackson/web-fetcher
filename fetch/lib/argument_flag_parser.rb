# frozen_string_literal: true

METADATA_FLAG = '--metadata'

# Has methods for parsing the command line arguments for flags
# TODO: Handle in cleaner way if case of more than one possible flag.
class ArgumentFlagParser
  def self.check_for_metadata_flag(arguments)
    has_flag = arguments[0] == METADATA_FLAG
    new_arguments = has_flag ? arguments[1..] : arguments
    [has_flag, new_arguments]
  end
end
