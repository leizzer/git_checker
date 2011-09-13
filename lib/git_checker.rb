require_relative "git_checker/version"
require_relative 'message_printer'
require_relative 'repository'
require_relative 'branch'

module GitChecker

  include MessagePrinter

  # Returns the branches from 'from' (Repository) that are not pushed to 'repo' (Repository)
  def branches_not_in repo, from, ignore=[]
    repo.missing_branches(from.list_of_branches) - ignore
  end

  # Prints the result from branches_not_in method
  def print_branches_not_in repo, from, ignore=[]
    print_message "Branches in #{from.name.capitalize} not in #{repo.name.capitalize}"
    puts branches_not_in(repo, from, ignore)
  end

  ################################################################

  # Returns the branches from 'from' (Repository) that are not merged in 'branch' (Branch)
  def branches_not_merged_in branch, from, ignore=[]
    branches = []
    from.branches.values.each do |b|
      unless ignore.include? b.name
        branches << b.name if branch.merges_with(b.name).empty?
      end
    end
    branches
  end

  # Prints the result from branches_not_merged_in method
  def print_branches_not_merged_in branch, from, ignore=[]
    print_message "Branches not in #{branch.name.capitalize}"
    puts branches_not_merged_in(branch, from, ignore)
  end

  ################################################################

  # Returns the commits from all the branches in 'from' (Repository) that are not in 'branch' (Branch)
  def print_commits_not_in branch, from, ignore=[]
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

  ################################################################

  #You ask, you answer and you have
  def check_group question, &block
    print "\n>>> #{question} [y/n] "
    answer = gets.strip
    if answer == 'y'
      yield
    end
  end

end
