class Branch
  
  attr_accessor :name, :repo

  def initialize name, repo=nil
    @name = name
    @repo = repo
  end

  def merges_with word
    log_merges.split.find_all { |merge| merge.include? word }
  end

  def log_merges
    `git log #{full_repo_name @repo}#{@name} --merges`
  end

  def commits_not_merged_from branch
    `git log --color #{full_repo_name @repo}#{@name}..#{full_repo_name(branch.repo)}#{branch.name}`
  end

  private
  
  def full_repo_name repo
    "#{repo}/" if repo
  end
end