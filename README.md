## vacation

Inspired by a tweet from [@mixonic](https://twitter.com/mixonic/status/638138156718686209), `vacation` is a program to ignore and re-watch repos on Github.

#### Usage

```sh
$ ./bin/vacation
Commands:
  vacation depart [FILE]   # Write to FILE and ignore all currently watched repos
  vacation help [COMMAND]  # Describe available commands or one specific command
  vacation return [FILE]   # Read from FILE and re-watch repos

```

#### Couldn't this be done by instead disabling Github notifications?

Yes, but who doesn't love building things? Plus, it gave me a reason to learn [octokit.rb](https://github.com/octokit/octokit.rb).
