# Note:  This script should *not* have the executable bit set.
# Executing it in a child shell is useless, it must be sourced in the
# current shell. That's why this file doesn't start with #!/bin/bash
eval `ssh-agent`
ssh-add
