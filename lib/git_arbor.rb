require 'trollop'
require_relative './git_arbor/old_branches'

module GitArbor
  class Runner
    def run
      options = fetch_arguments
      branches = GitArbor::OldBranches.new(days_old: options[:age])
      branches.identify
      branches.print
    end

    private

    def fetch_arguments
      Trollop.options do
        opt :age, 'Age in days', type: :integer
      end
    end
  end
end
