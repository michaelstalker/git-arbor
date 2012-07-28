require 'date'

module GitArbor
  class Runner

    AGE_THRESHOLD = Date.today - 180

    def old_branches
      branch_string = `git branch`
      branches = branch_array branch_string 
      branches.each do |branch|
        date_time = branch_date_time branch
        puts branch + " - #{date_time}" if date_time > AGE_THRESHOLD
      end
    end

    private

      def branch_array(branch_string)
        branch_collection = []

        branch_string.each_line do |branch|
          branch.strip!
          branch.sub! '* ', ''
          branch_collection << branch
        end

        branch_collection
      end

      def branch_date_time(branch)
        date_time_string = `git show #{branch} --format="%ci" | head -n 1`
        date_time = ::DateTime.parse date_time_string
      end
  end
end
