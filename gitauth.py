#!/usr/bin/python3

import configparser
import os
import pathlib
import sys

CONFIG_NAME = "user.cfg"
REPOS_PATH = "/opt/dev/repos"

def main():
    scriptpath = pathlib.Path(sys.argv[0])
    configpath = pathlib.Path(scriptpath.parent, CONFIG_NAME)
    if not configpath.exists():
        sys.exit("no user.cfg file found")
    config = configparser.ConfigParser()
    config.read(configpath)

    p = pathlib.Path(REPOS_PATH)
    for repopath in p.iterdir():
        gitconfig = repopath.joinpath(".git/config")
        if not gitconfig.is_file():
            continue
        #print("found git repo at {}".format(repopath))
        reponame = os.path.basename(repopath)
        splitname = reponame.split('.', maxsplit=1)
        if len(splitname) != 2:
            #print("...SKIPPING, since no prefix")
            continue
        prefix = splitname[0]
        if not config.has_section(prefix):
            #print("...SKIPPING, since prefix is not configured")
            continue
        if config.has_option(prefix, "name"):
            #print("...CALLING git config user.name")
            os.system("git config --file {} user.name {}".format(
                str(gitconfig),
                config.get(prefix, "name")
            ))
        if config.has_option(prefix, "email"):
            #print("...CALLING git config user.email")
            os.system("git config --file {} user.email {}".format(
                str(gitconfig),
                config.get(prefix, "email")
            ))


if __name__ == '__main__':
    main()
