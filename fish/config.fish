# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/enzoblain/.docker/bin"
# End of Docker Desktop section.

starship init fish | source
zoxide init fish | source

alias homeserver='cd /Volumes/"Home Server Enzo"/'

export NARGO_HOME="/Users/enzoblain/.nargo"

export PATH="$PATH:$NARGO_HOME/bin"
