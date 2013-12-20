module GitArbor
  class MergedBranches
    attr_reader :pruning_candidates

    def initialize
      @pruning_candidates = []
    end

    def identify
      branch_list = `git branch`
      branches = branch_array(branch_list)

      branches.each do |branch|
        pruning_candidates << branch if merged?(branch)
      end
    end

    def print
      puts 'Branches that have been merged with other branches:'

      pruning_candidates.each do |branch|
        puts branch
      end
    end

    private

    def branch_array(branch_list)
      branches = []

      branch_list.each_line do |branch|
        branch.strip!
        branch.sub! '* ', ''
        branches << branch
      end

      branches
    end

    def merged?(branch)
      `git checkout #{branch}`
      output = `git branch --contains`
      branch_count = output.each_line.count
      branch_count > 1
    end
  end
end
