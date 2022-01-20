# seting up a user profile

## files in home directory

- `~/.bash*` from `/etc/skel`
   for a more comfortable shell experience.
- `~/.bashrc`
   add `umask 0007`
- `~/.screenrc`
   for a more comfortable screen terminal multiplexing experience.
- `~/.netrc` **MUST NOT** be LDAP passwords of regular users
   used to log into some remote servers. **Always** use technical accounts (e.g.: for OpenBIS which normally relies on LDAP accounts) or local server-specific accounts. Machines:
    - `machine bs-openbis04.ethz.ch` (see `gfb.conf`)
    - `machine fgcz-gstore.uzh.ch` (see `fcgz.conf`)
    - `machine sftp.gc.health2030.ch` (see `h2030.conf`)
- `~/.ssh/config`
   controls various parameters of SSH connection.
    - ControlMaster **MUST NOT** be enabled (otherwise part of the parallelism gains are lost)
    - Hosts:
       - `Host bs-openbis04.ethz.ch`: **requires** some [special kex settings (See wiki)](https://wiki-bsse.ethz.ch/display/DBSSEQGF/openBIS+for+Illumina+NGS+Data+Management+-+Basic+Usage#openBISforIlluminaNGSDataManagement-BasicUsage-HowdoIgetmydata?) + special port (see `gfb.conf`)
       - `Host fgcz-gstore.uzh.ch`: special port (see `fcgz.conf`)
       - `Host sftp.gc.health2030.ch`: **relies on ** SSH key + optionnal special port (see `h2030.conf`)
       - `Host tsftp.viollier.ch`: **relies on** SSH key (not ED25519)
  - `~/.ssh/id_ed25519_batman` **MUST NOT** be a normal user key
    special-purpose SSH key used by `quasimodo` and `carrillon` to run `batman.sh`'s subcommands on Euler with forced-commands.
  - `~/.ssh/id_ed25519_belfry` **MUST NOT** be a normal user key
    special-purpose SSH key used by `belfry`'s subcommands to access stuff all around (rsync to Euler, lftp to SFTP servers) and to access belfry subcommands on other D-BSSE nodes
  - `~/.ssh/id_rsa_belfry` **MUST NOT** be a normal user key
    special-prupose SSH key for those target of `belfry`'s subcommand that do not support Ed25519 (e.g.: Viollier's SFTP doesn't)
  - `~/.ssh/authorized_keys`
     - operators
     - forced commands
        -  `belfry` subcommands for other server
 - `~/.ssh/known_hosts`
   known fingerprints of the SSH servers that will be contacted by automation.
    - `bs-openbis04.ethz.ch`
    - `fgcz-gstore.uzh.ch`
    - `sftp.gc.health2030.ch`
    - `tsftp.viollier.ch`
    - `euler.ethz.ch`
- `~/rsync.pass.euler` **MUST NOT** be LDAP password, **MUST** be in sync with rsyncd.secrets
   Password used to log into the rsyncd daemon, as an additional layer to SSH keys when performing rsyncd+ssh file exchange with forced commands.
- `~/`_{user}_`@d.ethz.ch.keytab` **SHOULD** be loged with the technical user's LDAP password
   used by cron job to keep kerberos tickets, see [below](#kerberos) and on [BSSE wiki](https://wiki-bsse.ethz.ch/display/DBSSEPUBLIC/Managing+Kerberos+tickets#ManagingKerberostickets-Keepyourticketvalidforunlimitedtime(theoretically))

## kerberos

following instruction on [BSSE wiki](https://wiki-bsse.ethz.ch/display/DBSSEPUBLIC/Managing+Kerberos+tickets#ManagingKerberostickets-Keepyourticketvalidforunlimitedtime(theoretically)):

- create keytab for technical users in `~/`_{user}_`@d.ethz.ch.keytab`
- either create a crontab entry or a systemd timer to renew it every 30 min (note: user units are broken on RedHat/CentOS/Fedora, use a root unit with proper UID/GID for the technical account)
- check crontab's automatic ticker creation with `klist`
   - ticket created by crontab should appear
-  check access to network storage, e.g.: `/links/shared/covid19-pangolin/backup`

## conda environments

- install the [latest mambaforge](https://github.com/conda-forge/miniforge#mambaforge) (this installs a miniconda environment with conda-forge channel enabled and with the newer mamba package manager available):
  ```bash
  # download installer
  wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
  # install it
  sh Mambaforge-Linux-x86_64.sh -b -p $HOME/miniconda3
  ```
  **note:**
   - for legacy reasons, the prefix is still called `miniconda3`
   - You **SHOULD NOT** load blindly conda or any other environment in the user's profile.
- extra software **MAY** be installed in the base conda environment:
  ```bash
  # load environment
  . ~/miniconda3/bin/activate
  # update package released since installer
  mamba update --all
  # install extra software
  mamba install git lftp curl pyyaml
  ```
  this may be available from other source (module environments, etc.), but using the conda-forge versions enables us to have more recent ones.
- install the conda environment with requirements for the sample sorting python scripts (PyBIS, etc.):
  ```bash
  # if not done before, load environment:
  . ~/miniconda3/bin/activate
  # install environment from yaml
  mamba env create -f /links/shared/covid19-pangolin/backup/conda_pybis_env.yaml
  ```
  **note:**
   - PyBIS it self isn't available on bioconda (yet), and will therefore be install by mamba using pip.
   - all other dependencies should be coming from conda-forge and bioconda.

## sudoers

  **note:** sudo rights need to be setup by admins over the pupper system

  - `nethogs`

## shell tabs:

These are the 3 shell tabs that are used in the `screen` multiplexer:

- `htop -u bs-pangolin@d`
- `sudo nethogs`
- `cd /links/shared/covid19-pangolin/backup; ./quasimodo`

## todo

- encrypt keys: prefered ssh-agent at D-BSSE ?
