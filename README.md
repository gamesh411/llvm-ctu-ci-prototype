# Buildbot for Clang CTU

This repository contains configuration prototypes for checking CTU functionality with
LLVM and Clang changes.

# Environment 
These configurations were created and tested with Buildbot version 0.8.5, on a virtual
machine running Ubuntu 16.04.1.

```
  uname -a
  Linux clang-buildbot 4.15.0-1037-azure #39~16.04.1-Ubuntu SMP Tue Jan 15 17:20:47 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux 
```

The PyPi package for Buildbot 0.8.5 contains requirements, in a format which is no longer
applicable with newer versions of pip. The buildbot can be installed by running
`scripts/install_master_buildbot_0_8_5.sh`, which crates a virtual environment and installs
the correct version of Buildbot with dependencies.

# Build steps
The master configuration polls the LLVM-Project monorepo (https://github.com/llvm/llvm-project),
and regards changes interesting if they affect either the llvm or clang source tree.
When and interesting change is detected, it builds a release clang build. CodeChecker
(https://github.com/Ericsson/codechecker) is then used to drive the CTU analysis on tmux.

# Caveats
Handling external source repositories with the Git build step in version 0.8.5 proved to
be problematic, hence the custom shallow cloning steps used in the master configuration. 

