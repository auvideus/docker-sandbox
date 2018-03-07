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

### Configuring Fish

.fish configuration can be placed in the conf.d/ directory in this repo and they will be copied to the image.

### Configuring Git

Make sure your email and user are set in the `.gitconfig` file on the host.  Setting a Git proxy is optional and will be copied only if it is set on the host.

```
git config --global user.name <your name>
git config --global user.email <your email>
git config --global https.proxy <https proxy>
git config --global http.proxy <http proxy>
```

Since the container assumes Git credentials will be in a file provided by the host, it makes sense to use the *store* type credentials on the host as well.  To get this working it is best to not install Windows credential manager when installing Git Bash.

`git config --global credential.helper 'store --file .../security/.git-credentials'`

To store a GitHub token in `.git-credentials`, put a line with this format in the file:
 
`https://<user>:<token>@github.com`

One last feature is a script that is run on login that sets per-repository user.name and user.email settings.  To configure that. create a file `user.cfg` in the clone of this repo.  Section headers correspond to dot-separated repository directory name prefixes in the repos/ folder.

```
[prefix] # Matches all repos/ repositories starting with "prefix."
User = someuser
Email = someuser@someuser.me
```

## Running the sandbox

Edit the `.bashrc` file in your home directory on the host to configure the environment.

Specify the locations of the three root directories mentioned above:

```
export VOL_DEV=...
export VOL_HOME=...
export VOL_SECURITY=...
# note: use c:/some/directory syntax

# only needed if using per-repository git settings
export SANDBOX_REPO_NAME=...
```

To run the environment, run the following.  This can be placed at the end of the `.bashrc` file to have it run automatically upon entering Git Bash, which can be pinned to the Windows task bar.

```
cd <path to clone of this repo>
./run.sh
```
