# Defined in /tmp/fish.sG8oUu/fish_prompt.fish @ line 2
function fish_prompt
    # This prompt shows:
    # - 0000ff lines if the last return command is OK, ff0000 otherwise
    # - your user name, in ff0000 if root or yellow otherwise
    # - your hostname, in cyan if ssh or blue otherwise
    # - the current path (with prompt_pwd)
    # - date +%X
    # - the current virtual environment, if any
    # - the current git status, if any, with fish_git_prompt
    # - the current battery state, if any, and if your power cable is unplugged, and if you have "acpi"
    # - current background jobs, if any

    # It goes from:
    # ┬─[nim@Hattori:~]─[11:39:00]
    # ╰─>$ echo here

    # To:
    # ┬─[nim@Hattori:~/w/dashboard]─[11:37:14]─[V:django20]─[G:master↑1|●1✚1…1]─[B:85%, 05:41:42 remaining]
    # │ 2	15054	0%	arrêtée	sleep 100000
    # │ 1	15048	0%	arrêtée	sleep 100000
    # ╰─>$ echo there

    set -l retc ff0000
    test $status = 0; and set retc 0000ff

    set -q __fish_git_prompt_showupstream
    or set -g __fish_git_prompt_showupstream auto

    function _nim_prompt_wrapper
        set retc $argv[1]
        set field_name $argv[2]
        set field_value $argv[3]

        set_color normal
        set_color -o $retc
        echo -n '─'
        set_color -o $retc
        echo -n '['
        set_color normal
        echo -n $field_name
        echo -n $field_value
        set_color -o $retc
        echo -n ']'
    end

    set_color -o $retc
    echo -n '┬─'
    set_color -o $retc
    echo -n [
    if test "$USER" = root -o "$USER" = toor
        set_color -o ff0000
    else
        set_color -o $fish_color_command
    end
    echo -n $USER
    set_color -o ffffff
    echo -n @
    if [ -z "$SSH_CLIENT" ]
        set_color -o $fish_color_param
    else
        set_color -o cyan
    end
    echo -n (prompt_hostname)
    set_color -o ffffff
    echo -n ':'
    set_color -o $fish_color_command
    echo -n (prompt_pwd)
    set_color -o $retc
    echo -n ']'

    # Date
    _nim_prompt_wrapper $retc '⏳' (
	set color -o $fish_color_command
    	echo -n (date +%X)
	)

    # Virtual Environment
    set -q VIRTUAL_ENV_DISABLE_PROMPT
    or set -g VIRTUAL_ENV_DISABLE_PROMPT true
    set -q VIRTUAL_ENV
    and _nim_prompt_wrapper $retc V (basename "$VIRTUAL_ENV")

    # git
    set prompt_git (fish_git_prompt | string trim -c ' ()')
    test -n "$prompt_git"
    and _nim_prompt_wrapper $retc G $prompt_git

    # Battery status
    type -q acpi
    and test (acpi -a 2> /dev/null | string match -r off)
    and _nim_prompt_wrapper $retc '⚡' (battery)

    # New line
    echo

    # Background jobs
    set_color normal
    for job in (jobs)
        set_color $retc
        echo -n '│ '
        set_color brown
        echo $job
    end
    set_color normal
    set_color -o $retc
    echo -n '╰─>'
    set_color -o $fish_color_command
    echo -n '🎼 '
    set_color normal
end
