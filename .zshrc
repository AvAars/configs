COMPLETION_WAITING_DOTS="true"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

chmod go-w -R "$HOME/.local"

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
# zinit light-mode for \
#     zdharma-continuum/zinit-annex-as-monitor \
#     zdharma-continuum/zinit-annex-bin-gem-node \
#     zdharma-continuum/zinit-annex-patch-dl \
#     zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# zinit light zdharma-continuum/fast-syntax-highlighting
# zinit light zsh-users/zsh-autosuggestions
# zinit light zsh-users/zsh-completions

#zinit wait lucid for \
#        OMZL::git.zsh \
#        OMZP::git

zinit light-mode depth=1 for \
    romkatv/powerlevel10k \
    OMZL::history.zsh

setopt promptsubst

# Needed for docker completion
mkdir -p "$ZSH_CACHE_DIR/completions" && chmod go-w "$ZSH_CACHE_DIR/completions"

# Official docker completion?
# docker completion zsh | tee "$ZINIT[COMPLETIONS_DIR]/_docker" > /dev/null

# ln -sf "$ZSH_CACHE_DIR/completions/_docker" "$ZINIT[COMPLETIONS_DIR]/_docker"

zinit wait lucid for \
    OMZL::clipboard.zsh \
    OMZL::compfix.zsh \
    OMZL::directories.zsh \
    OMZL::prompt_info_functions.zsh \
    OMZL::completion.zsh \
    OMZL::git.zsh \
    OMZL::grep.zsh \
    OMZL::spectrum.zsh \
    OMZP::colored-man-pages \
    nocompletions OMZP::docker \
    OMZP::git \
    OMZP::git-lfs \
    OMZP::docker-compose \
  as"completion" \
    OMZP::docker/completions/_docker

zinit wait lucid light-mode for \
  atinit"ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20" atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  atinit"zicompinit; zicdreplay"  \
    zdharma-continuum/fast-syntax-highlighting \
  blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export cdpath=(. ~)

setopt AUTO_CD