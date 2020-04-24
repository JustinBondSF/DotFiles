# Defined in /home/bond/.config/fish/functions/fish_prompt.fish @ line 2
function fish_prompt
    set -U Rseperator \ue0c4
    set -U Lseperator \uE0CA
    set -U Rfade ▓▒░
    set -U Lfade ░▒▓       
    set -U right_arrow_glyph \ue0c4
    set -U left_arrow_glyph \uE0B2


    set retc ff0000
        test $status = 0; and set retc 0000ff

    set -q __fish_git_prompt_showupstream
    or set -g __fish_git_prompt_showupstream auto


    function _nim_prompt_wrapper
        set retc $argv[1]
        set field_name $argv[2]
        set field_value $argv[3]
	    set optional $argv[4]
        test $optional; and $optional	
        echo -n $field_name
        echo -n $field_value

 
    end



        switch $fish_bind_mode
            case default
                set_color --bold --background green ffffff
                echo -n '[N] '
                set_color --bold --background $retc green
                echo -n $Rseperator
            case insert
                set_color --bold --background 8b00b5 ffffff
                echo -n '[I] '
                set_color --bold --background $retc 8b00b5
                echo -n $Rseperator
            case replace_one
                set_color --bold --background cyan ffffff
                echo -n '[R] '
                set_color --bold --background $retc cyan
                echo -n $Rseperator
            case replace
                set_color --bold --background ffa500 ffffff
                echo -n '[R] '
                set_color --bold --background $retc ffa500
                echo -n $Rseperator
            case visual
                set_color --bold --background  magenta ffffff
                echo -n '[V] '
                set_color --bold --background $retc magenta
                echo -n $Rseperator
        end
        set_color normal

    set_color -o $retc
 
    if test "$USER" = root -o "$USER" = toor
        set_color -o ff0000 -b $retc
    else
        set_color -o $fish_color_command -b $retc
    end
    echo -n $USER
    set_color -o ffffff -b $retc
    echo -n @
    if [ -z "$SSH_CLIENT" ]
        set_color -o $fish_color_command -b $retc
    else
        set_color -o cyan
    end
    echo -n (prompt_hostname)
    set_color -o $retc -b 222222
    echo -n $right_arrow_glyph
    set_color -o $fish_color_command -b 222222
    echo -n ' '(prompt_pwd)' '
    set_color -o 222222 -b 444444
    echo -n $right_arrow_glyph

    # Date
    
    set clock ( set_color -o ffffff -b 444444
		                echo -n '⏰' )	

	set _date ( set_color -o ffffff -b 444444
                        echo -n (date +%X) ) 
               
     echo -n $clock 
     echo -n $_date
     set_color 444444 -b 222222
     echo -n $right_arrow_glyph

 
    # Virtual Environment
    #set -q VIRTUAL_ENV_DISABLE_PROMPT
    #or set -g VIRTUAL_ENV_DISABLE_PROMPT true
    #set -q VIRTUAL_ENV
    #and _nim_prompt_wrapper $retc V (basename "$VIRTUAL_ENV")


    # git

    set prompt_git (fish_git_prompt | string trim -c ' ()')
    test -n "$prompt_git"
    and _nim_prompt_wrapper $retc G $prompt_git

    # Battery status

    set battery_glyph (
        set -U battery_percent (
            acpi -b | string match -r '..%' | string replace \% '' | string trim
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
    
    type -q acpi
    and test (acpi -a 2> /dev/null | string match -r off);
      and echo -n ' '$battery_glyph
    set_color -b 222222
    echo -n ' '$battery_glyph' '
    set_color -o 222222 -b 000000
    echo -n $Rseperator


    # New line
    echo

    # Background jobs
    set_color normal
    for job in (jobs)
        set_color $retc -b $retc
        echo -n '│ '
        set_color brown
        echo $job
    end


    set_color normal
    set_color -o $retc
    echo -n $Lfade
    set_color -o ffffff -b $retc
    echo -n '🎼 '
    set_color normal
    set_color $retc 
    echo -n $right_arrow_glyph
    set_color normal
end
