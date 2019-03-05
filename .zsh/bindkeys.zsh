# To see the key combo you want to use just do:
# cat > /dev/null
# And press it

bindkey "^K"      kill-whole-line                      # ctrl-k
bindkey "^R"      history-incremental-search-backward  # ctrl-r
bindkey "^A"      beginning-of-line                    # ctrl-a 
bindkey "\eOH"    beginning-of-line                    # home
bindkey "\e[H"    beginning-of-line                    # home
bindkey "\e[1~"   beginning-of-line                    # home
bindkey "\e[7~"   beginning-of-line                    # home
bindkey "^E"      end-of-line                          # ctrl-e
bindkey "\eOF"    end-of-line                          # end
bindkey "\e[F"    end-of-line                          # end
bindkey "\e[4~"   end-of-line                          # end
bindkey "\e[8~"   end-of-line                          # end
bindkey "[B"      history-search-forward               # down arrow
bindkey "[A"      history-search-backward              # up arrow
bindkey "^D"      delete-char                          # ctrl-d
bindkey "\e[3"    delete-char                          # ctrl-d
bindkey "^F"      forward-char                         # ctrl-f
bindkey "^B"      backward-char                        # ctrl-b
bindkey -e   # Default to standard emacs bindings, regardless of editor string
