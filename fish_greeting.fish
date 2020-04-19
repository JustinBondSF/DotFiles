# Defined in /tmp/fish.7IpoFQ/fish_greeting.fish @ line 2
function fish_greeting --description What\'s\ up,\ fish\?
fish_logo  | lolcat

fortune |lolcat
	

    # TODO: `command -q -s` only works on fish 2.5+, so hold off on that for now
    command -s uptime >/dev/null


    set_color normal
end
