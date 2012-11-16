require 'date'
require_relative './git_arbor/old_branches'

module GitArbor
  class Runner

    def run(arguments)
      branches = GitArbor::OldBranches.new
      branches.identify
      branches.print
    end
  end
end
