## vacation

Inspired by a tweet from [@mixonic](https://twitter.com/mixonic/status/638138156718686209), `vacation` is a program to auto-ignore and re-watched repos on Github.

#### Usage

```sh
$ ./bin/vacation
Commands:
  vacation depart [FILE]   # Write current subscriptions to FILE and ignore all repos
  vacation help [COMMAND]  # Describe available commands or one specific command
  vacation return [FILE]   # Read subscriptions from FILE and re-instate all subscriptions

```

#### Couldn't this be easily done by disabling both Web and Email notifications?

Yes, but who doesn't love building things? Plus, it gave me a reason to learn `octokit`.


