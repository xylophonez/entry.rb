# entry.rb - a CLI tool to generate a static blog

## Setup
1. `bundle`
2. `sh install.sh`
3. `./makeit`


You now have the directories that entry.rb expects on your machine, and - assuming that ~/.local/bin is in your path - can run the `entry` and `generate` commands. If you don't have ~/.local/bin in your path, an alternative is to alias these commands to the paths shown in the `makeit` script.

## Usage

1. The `entry` command can be issued without arguments (to input text for a new blog entry on the terminal), or with a file path, e.g. `entry /tmp/mypost`. 
2. `entry` expects markdown for formatting, so plain text also works
3. After adding new entries with the `entry` command, run `generate` to generate a new index.html using your local repository of entries located at ~/Documents/entries.

I'd suggest a simple script using rsync to copy over index.html and the assets folder to your server.

The general workflow is:

```
entry /tmp/mypost
generate
sh hostit
```

...with hostit being a script containing something like:

`rsync -r /home/username/site/*  you@your-server:/var/www/your.domain.com/public_html`


