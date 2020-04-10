# Defined in /tmp/fish.R5YVlo/fish_right_prompt.fish @ line 2
function fish_right_prompt
    set -l left_arrow_glyph \uE0B3
	set retc ff0000
	test $status = 0; and set retc 0000ff	


    if test $CMD_DURATION

        # Show duration of the last command in seconds

        set duration (echo "$CMD_DURATION 1000" | awk '{printf "%.3fs", $1 / $2}')
	set_color -o $retc
        echo $duration

    end

     echo -n  $left_arrow_glyph
     set_color -o $fish_color_command
     echo -n '♪ ♫ ♬ ♫ ♬ ♪'

     set_color normal
end
