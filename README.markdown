Git Checker
===========
screenshot: http://dl.dropbox.com/u/5847684/Screen%20shot%202011-06-30%20at%201.05.43%20PM.png

It is useful for keep an eye on your git repositories, what branch has been not merged yet, commits not in some branch and more.

"It's like a Test for your git"

Install:
--------

`gem install git_checker`

Usage:
------

Create a file with the extension .gck.rb

    touch checkthis.gck.rb

Add some checks in that file, like:

    #checkthis.gck.rb
    local = Repository.new
    print_commits_not_in local.branches['master'], local

Then run the command: 
`gck`

Available Checks:
-----------------
* branches_not_in repo, from, ignore=[]
* branches_not_merged_in branch, from, ignore=[]
* commits_not_in branch, from, ignore=[]

More:
-----

You can also ask for run task that you not always want, like this:

    #checkthis.gck.rb
    local= Repository.new
    remote= Repository.new 'origin'
    ignore= %w(backup test) #for ignore this branches in the list

    print_commits_not_in local.branches['master'], local, ignore

    check_group "Check for branches not in Remote?" do

      print_branches_not_in remote, local, ignore

    end #>>> Check for branches not in Remote? [y/n]

You can skip this questions an run all with the command `agck`

Please:
-------
Feedback.

note: the merges should be done with `--no-ff` option for create a commit message in every merge.