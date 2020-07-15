# Defined in /var/folders/7w/8kyl32496f5c3c432t186kjh0000gn/T//fish.DYwun2/fish_prompt.fish @ line 2
function fish_prompt

    #create glyph references, color the output based on [ret]urn [c]ode aka prev cmd success or fail
    set -U Rseparator \uE0D2
    set -U Lseparator \uE0D4
    set -U Rfade ▓▒░
    set -U Lfade ░▒▓
    set retc ff0000
    test $status = 0; and set retc 0000ff

    set -q __fish_git_prompt_showupstream
    or set -g __fish_git_prompt_showupstream auto



    #VI mode dynamic prompt segment
    switch $fish_bind_mode
        case default
            set_color --bold --background green ffffff
            echo -n '[N]'
            set_color --bold --background $retc green
            echo -n $Rseparator
        case insert
            set_color --bold --background 8b00b5 ffffff
            echo -n '[I]'
            set_color --bold --background $retc 8b00b5
            echo -n $Rseparator
        case replace_one
            set_color --bold --background cyan ffffff
            echo -n '[R]'
            set_color --bold --background $retc cyan
            echo -n $Rseparator
        case replace
            set_color --bold --background ffa500 ffffff
            echo -n '[R]'
            set_color --bold --background $retc ffa500
            echo -n $Rseparator
        case visual
            set_color --bold --background magenta ffffff
            echo -n '[V]'
            set_color --bold --background $retc magenta
            echo -n $Rseparator
    end

    #Display red username if root, or use the color of commands if not
    # and color the background according to previous command success or #   fail

    if test "$USER" = root -o "$USER" = toor
        set_color -o ff0000 -b $retc
    else
        set_color -o $fish_color_command -b $retc
    end
    echo -n $USER


    set_color -o ffffff -b $retc
    echo -n '  '



    #Display host name, cyan if ssh, command color if not, color background 
    # according to previous command
    if [ -z "$SSH_CLIENT" ]
        set_color -o $fish_color_command -b $retc
    else
        set_color -o cyan
    end
    echo -n (prompt_hostname)
    set_color -o $retc -b 222222
    echo -n $Rseparator

    #Current directory segment
    set pin (set_color -o ffffff -b 222222 
    echo -n '  ')
    echo -n $pin
    set_color -o $fish_color_command -b 222222
    echo -n (prompt_pwd)' '
    set_color -o 222222 -b 444444
    echo -n $Rseparator

    # Date

    set clock ( set_color -o ffffff -b 444444
		                echo -n '  ' )

    set _date ( set_color -o ffffff -b 444444
                        echo -n (date +%X) )

    echo -n $clock
    echo -n $_date
    set_color 444444 -b 222222
    echo -n $Rseparator


    # Virtual Environment
    #set -q VIRTUAL_ENV_DISABLE_PROMPT
    #or set -g VIRTUAL_ENV_DISABLE_PROMPT true
    #set -q VIRTUAL_ENV
    #and _nim_prompt_wrapper $retc V (basename "$VIRTUAL_ENV")


    # git

    set prompt_git (fish_git_prompt | string trim -c ' ()')
    test -n "$prompt_git"
    and set_color -b $retc
    echo -n  + ' ' + $prompt_git

    # Battery percentage displayed in red, yellow, and green glyphs 

    set battery_glyph (
            set -U battery_percent (
                battery 
                                    )

        switch $battery_percent 
            case '9*'
                set_color -o green -b 222222
                echo -n \uf583
            case '8*'
                set_color -o green -b 222222
                echo -n \uf581
            case '7*'
                set_color -o green -b 222222
                echo -n \uf580
            case '6*'
                set_color -o yellow -b 222222
                echo -n \uf57f
            case '5*'
                set_color -o yellow -b 222222
                echo -n \uf57e
            case '4*'
                set_color -o yellow -b 222222
                echo -n \uf57d
            case '3*'
                set_color -o red -b 222222
                echo -n \uf57c
            case '2*'
                set_color -o red -b 222222
                echo -n \uf57b
            case '1*'
                set_color -o red -b 222222
                echo -n \uf57a
            case '^*\$'
                set_color -o red -b 222222
                echo -n \uf579   
            end
    )
    echo -n ' '$battery_glyph' '
    set_color -o 222222 -b 000000
    echo -n $Rseparator


    # New line
    echo

    #  Background jobs
    set_color normal
    for job in (jobs)
        set_color $retc -b $retc
        echo -n '│ '
        set_color brown
        echo $job
    end


    #2nd line prompt, colored by previous command success/fail
    #command line = composing music!
    #continued in right prompt
    set_color normal
    set_color -o $retc
    echo -n $Lfade
    set_color -o ffffff -b $retc
    echo -n ' 🎼 '
    set_color normal
    set_color $retc
    echo -n $Rseparator
    set_color normal
end
