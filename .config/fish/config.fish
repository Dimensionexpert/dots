if status is-interactive
    # Commands to run in interactive sessions can go here
    alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

    alias da='dot add'
    alias dc='dot commit -m'
    alias dp='dot push'
    alias ds='dot status'
end