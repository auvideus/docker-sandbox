# docker-sandbox

This is a docker sandbox environment for Windows 10 hosts using Git Bash.  Git Bash and Docker for Windows must be installed as prerequisites.

## Host file system structure

The Dockerfile assumes three directory structures are present on the host:

```
C:/Users/<user>/ # normal Windows user home directory
    .gitconfig
.../docker/
    gopath/ # GOPATH on the host points here
        bin/
    repos/ # directory containing local clones of repositories
.../security/ # security tokens
    .git-credentials
    id_rsa
    id_rsa.pub
```

Make sure your email and user are set in the `.gitconfig` file.

Additionally, since the container assumes Git credentials will be in a file provided by the host, it makes sense to use the *store* type credentials on the host as well, which is achieved with the command below.  You may also want to make sure you don't install the Windows credential manager when installing Git.

`git config --global credential.helper 'store --file .../security/.git-credentials'`

To store a GitHub token, put a line with this format in the file:
 
`https://<user>:<token>@github.com`

## Running the sandbox

Edit the `.bashrc` file in your home directory on the host to configure the environment.

Specify the locations of the three root directories mentioned above:

```
export VOL_DEV=...
export VOL_HOME=...
export VOL_SECURITY=...
# note: use c:/some/directory syntax
```

To run the environment, run the following.  This can be placed at the end of the `.bashrc` file to have it run automatically upon entering Git Bash, which can be pinned to the Windows task bar.

```
cd <path to clone of this repo>
./run.sh
```
