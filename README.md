# Format for Plex

This bash script formats the file names in a targeted directory to match the Plex Media Server formatting guidelines.

## Install

1. Clone repository
1. Change permission to make the file executable
1. Create a symbolic link to `format4plex.sh` in any of your `bin` directories


Execute `echo $PATH` to see what paths are already in your `PATH` environment variable. The potential directories are:

- /usr/local/bin
- /usr/local/sbin
- /usr/bin
- /usr/sbin
- ~/bin
- ~/local/bin

```bash
chmod u+x format4plex.sh
sudo ln -s /path/to/plex-formatting/format4plex.sh /usr/local/bin/format4plex
```

> Note: If you need to use the `sudo` command with the script then place the symbolic link inside `/usr/sbin` directory.

## TODO

1. Figure out how to convert '1x01' to 's01e01'
1. Remove certain patterns (use external file as a database) - have user input pattern to remove if it only removes formatting then don't go through the entire process of filtering and renaming.
  - ie: --pattern-to-remove DVDrip.Xvid.mp3

## References

1. <https://support.plex.tv/articles/200220687-naming-series-season-based-tv-shows/>
1. <https://support.plex.tv/articles/203810286-what-media-formats-are-supported/>