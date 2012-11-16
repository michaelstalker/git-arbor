require 'date'
require_relative './git_arbor/old_branches'

module GitArbor
  class Runner

    def run(arguments)
      p GitArbor::OldBranches.identify
    end
  end
end
