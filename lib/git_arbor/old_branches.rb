module GitArbor
  module OldBranches
    AGE_THRESHOLD = Date.today - 180

    def self.identify
      branch_string = `git branch`
      branches = branch_array branch_string
      branches.each do |branch|
        print_date(branch) if branch_date_time(branch) < AGE_THRESHOLD
      end
    end
    
    private

    def self.branch_array(branch_string)
      branch_collection = []

      branch_string.each_line do |branch|
        branch.strip!
        branch.sub! '* ', ''
        branch_collection << branch
      end

      branch_collection
    end

    def self.branch_date_time(branch)
      date_time_string = `git show #{branch} --format="%ci" | head -n 1`
      date_time = ::DateTime.parse date_time_string
    end

    def self.print_date(branch)
      date_time = branch_date_time branch
      date = date_time.to_date
      puts branch + " - #{date}"
    end
  end
end
