# ===== System =====
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'
alias ..='cd ..'
alias ...='cd ../..'

# ===== Networking =====
alias ports='ss -tulnp'
alias ipinfo='ip a'
alias routes='ip r'

# ===== SOC / Blue Team =====
alias logs='journalctl -xe'
alias authlog='sudo tail -f /var/log/auth.log'
alias apachelog='sudo tail -f /var/log/apache2/access.log'

# ===== Safety =====
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# ---- common ----
alias vi='nvim'
alias less='less -S'
