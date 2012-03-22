Git Checker
===========
screenshot: http://dl.dropbox.com/u/5847684/Screen%20shot%202011-06-30%20at%201.05.43%20PM.png

The target of this gem is to make it easy to perform automated checks on your git repository.

Install:
--------

`gem install git_checker`

Usage:
------

Create a file with the extension .gck.rb in the root of your project

    touch checkthis.gck.rb

Add some checks in that file, like:

```ruby
    #checkthis.gck.rb
    local = Repository.new
    print_commits_not_in local.branches['master'], local
```

**Then run the command in the directory:**
`gck`

Available Checks:
-----------------
* branches_not_in repo, from, ignore=[]
    * print_branches_not_in repo, from, ignore=[]
* branches_not_merged_in branch, from, ignore=[]
    * print_branches_not_merged_in branch, from, ignore=[]
* print_commits_not_in branch, from, ignore=[]

More:
-----

You can also ask for run task that you not always want, like this:

```ruby
    #checkthis.gck.rb
    local= Repository.new
    remote= Repository.new 'origin'
    ignore= %w(backup test) #for ignore this branches in the list

    print_commits_not_in local.branches['master'], local, ignore

    check_group "Check for branches not in Remote?" do

      print_branches_not_in remote, local, ignore

    end #>>> Check for branches not in Remote? [y/n]
```

You can skip this questions an run all with the command `agck`

Log format
----------

By default it uses the standard log format, with color. You can add a `gck` section in your `~/.gitconfig` file to change it:

```
[gck]
  format = "--pretty=format:'%Cblue%h%Creset -%C(yellow)%d%Creset %s - %C(yellow)%aN%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
```

Screenshot: http://dl.dropbox.com/u/2247903/gck-custom-log.png

Please:
-------
Feedback.

note: the merges should be done with `--no-ff` option for create a commit message in every merge.
