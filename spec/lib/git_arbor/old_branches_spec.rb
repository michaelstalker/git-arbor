require 'git_arbor/old_branches'

describe GitArbor::OldBranches do
  let(:branches) { GitArbor::OldBranches.new }
  before { branches.stub(:branch_list_string).and_return("* master\ndevelop") }

  describe '#print' do
    pending
  end
end
