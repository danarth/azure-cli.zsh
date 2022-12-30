# Check az-cli is actually installed
if (( ! $+commands[az] )); then
  return
fi

# Load az-cli completions
function _azcli-homebrew-installed() {
    # check if Homebrew is installed
    (( $+commands[brew] )) || return 1

    # speculatively check default brew prefix
    if [ -h /usr/local/opt/azure-cli ]; then
        _brew_prefix=/usr/local/opt/azure-cli
    else
        # ok, it is not in the default prefix
        # this call to brew is expensive (about 400 ms), so at least let's make it only once
        _brew_prefix=$(brew --prefix azure-cli)
    fi
}

# Homebrew
if _azcli-homebrew-installed; then
  _az_zsh_completer_path=$_brew_prefix/etc/bash_completion.d/az
# Ubuntu
else
  _az_zsh_completer_path=/etc/bash_completion.d/azure-cli
fi

[[ -r $_az_zsh_completer_path ]] && source $_az_zsh_completer_path
unset _az_zsh_completer_path _brew_prefix
