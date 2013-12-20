require 'rubygems'
require 'trollop'
require_relative './git_arbor/old_branches'
require_relative './git_arbor/merged_branches'

module GitArbor
  class Runner
    def run
      options = fetch_arguments
      branches = GitArbor::OldBranches.new(days_old: options[:age])
      branches = GitArbor::MergedBranches.new if options[:merged]
      branches.identify
      branches.print
    end

    private

    def fetch_arguments
      Trollop.options do
        opt :age, 'Age in days', type: :integer
        opt :merged, 'Return branches that have been merged', type: :boolean
      end
    end
  end
end
