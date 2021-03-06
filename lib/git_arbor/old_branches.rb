require 'date'

module GitArbor
  class OldBranches
    attr_reader :days_old, :date_threshold

    def initialize(options = {})
      @days_old = options[:days_old] || 180
      @pruning_candidates = []
    end

    def identify
      branch_list = `git branch`
      branches = branch_array(branch_list)

      branches.each do |branch|
        @pruning_candidates << branch if branch_date_time(branch) < date_threshold
      end
    end

    def print
      puts "Old branches (older than #{days_old} days old):"

      @pruning_candidates.each do |branch|
        print_date(branch)
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

    def branch_date_time(branch)
      date_time_string = `git show #{branch} --format="%ci" | head -n 1`
      date_time = DateTime.parse(date_time_string)
    end

    def print_date(branch)
      date_time = branch_date_time(branch)
      date = date_time.to_date
      puts branch + " - #{date}"
    end

    def date_threshold
      Date.today - days_old
    end
  end
end
