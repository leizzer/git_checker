class Branch

  attr_accessor :name, :repo

  def initialize name, repo=nil
    @name = name
    @repo = repo
  end

  def commit_hash
    `git show -s --pretty="%H" #{full_name}`.strip
  end

  def contains? branch
    commits_not_merged_from(branch).empty?
  end

  def log_merges
    `git log #{format} #{full_name} --merges`
  end

  def format
    format = `git config --get gck.format 2> /dev/null`.strip
    return format unless format.empty?
    "--color"
  end

  def commits_not_merged_from branch
    `git log #{format} #{full_name}..#{branch.full_name}`
  end

  def full_name
    "#{full_repo_name(@repo)}#{@name}"
  end

  private

  def full_repo_name repo
    "#{repo}/" if repo
  end
end
