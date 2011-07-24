class Repository
  
  attr_accessor :branches, :name

  def initialize(repo = nil)
    @name = repo || 'local' 
    collect_branches_from repo
  end

  def missing_branches branch_list
    branch_list.find_all {|b| !list_of_branches.include? b }
  end

  def list_of_branches
    @branches.keys
  end

  private

  def collect_branches_from repo
    @branches = {}
    list_branches(repo).each do |b|
      @branches[b] = Branch.new b, repo
    end
  end

  def list_branches repo
    if repo
      branches = branch_name `git branch -r`.split, repo
    else
      branches = `git branch`.split
    end
    branches - ['*']
  end

  def branch_name list, repo
    list.map { |b| b.sub "#{repo}/", '' }
  end
  
end
