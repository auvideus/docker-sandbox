This is a docker sandbox environment for Windows 10 hosts using Git Bash.  Git Bash and Docker for Windows must be installed as prerequisites.

## Host file system structure

The Dockerfile assumes three directory structures are present on the host:

```
C:/Users/<user> # normal Windows user home directory
    .gitconfig
.../docker
    gopath # GOPATH on the host points here
    repos # directory containing local clones of repositories
.../security # security tokens
    .git-credentials
    id_rsa
    id_rsa.pub
```

## Running the sandbox

Edit the `.bashrc` file in your home directory on the host to configure the environment.

Specify the locations of the three root directories mentioned above:

```
export VOL_DEV=...
export VOL_HOME=...
export VOL_SECURITY=...
# note: user c:/some/directory syntax
```

To run the environment, run the following.  This can be placed at the end of the `.bashrc` file to have it run automatically upon entering Git Bash, which can be pinned to the Windows task bar.

```
cd <path to clone of this repo>
./run.sh
```
