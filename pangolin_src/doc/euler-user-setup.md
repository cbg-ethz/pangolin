# seting up a user profile on Euler

## submission rights

- D-BSSE admins need to add user to group owning the shares (e.g.: `BSSE-Beerenwinkel-Euler`)
- check cluster shares with `my_share_info` (or listing member of a share, e.g.: `bugroup es_beere`)

## files in home directory

- `~/.bashrc`
  add `umask 0007`
- `~/.screenrc`
  for a more comfortable screen terminal multiplexing experience.
- `~/.netrc` **MUST NOT** be LDAP passwords of regular users
- `~/.ssh/config`
  controls various parameters of SSH connection.
   - ControlMaster **MUST NOT** be enabled (otherwise part of the parallelism gains are lost)
   - Hosts:
      - `bs-bewi08.ethz.ch`: specify the `@d` domain-suffix for D-BSSE
- `~/.ssh/authorized_keys`
   - operators
   - forced commands
      -  `batman.sh` subcommands for remote bs-bewi08 calls, both directly and from belfry dispatcher (2 different user keys)

- `~/rsyncd.secrets` **MUST NOT** be LDAP password, **MUST** be in sync with rsyncd.pass.euler
- `~/rsyncd.conf`
   - symlink to the conf file
   - `~/log` : used to store logs
   - `~/log/rotate`: symlink to log rotate script
   - `~/log/rotate.conf`: symlink to log rotate conf

## conda environments

**Notes:**
 - most of the environments will be auto-magically handled by snakemake using mamba
 - the conda installation is system-wide in `/cluster/project/pangolin` and already done by the `quick_install.sh` installer
 - custom environment from `conda-qa.yaml` already installed there
