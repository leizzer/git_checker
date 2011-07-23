require_relative "git_checker/version"
require_relative 'message_printer'
require_relative 'repository'
require_relative 'branch'

module GitChecker

  include MessagePrinter

  #def compare_branches_between_repos target_repo, repo_to_compare, ignore=[]
  def branches_not_in repo, from, ignore=[]
    print_message "Branches in #{from.name.capitalize} not in #{repo.name.capitalize}"
    puts repo.missing_branches(from.list_of_branches) - ignore
  end

  #def check_if_branches_are_merged_in target_branch, repo_to_check, ignore=[]
  def branches_not_merged_in branch, from, ignore=[]
    print_message "Branches not in #{branch.name.capitalize}"
    branches = []
    from.branches.values.each do |b|
      unless ignore.include? b.name
        branches << b.name if branch.merges_with(b.name).empty?
      end
    end
    puts branches
  end

  #def check_what_commits_not_merged_with target_branch, repo_to_check, ignore=[]
  def commits_not_in branch, from, ignore=[]
    print_message "Commits not in #{branch.name.capitalize}"
    from.branches.each_value do |b|
      unless ignore.include? b.name
        log = branch.commits_not_merged_from b
        unless log.empty?
          print_message "#{b.name}: Commits not on #{branch.name.capitalize}", :color => "\e[31m", :pound => '+'
          puts log
        end
      end
    end
  end

end
