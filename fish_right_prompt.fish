# Defined in /tmp/fish.EwS3o9/fish_right_prompt.fish @ line 2
function fish_right_prompt

#create glyph references, color the output based on [ret]urn [c]ode aka prev cmd success or fail

    set -U left_arrow_glyph \uE0B2
	set -U Rfade ▓▒░
	set -U Lfade ░▒▓ 	   
	set -l  retc ff0000
	test $status = 0; and set -l retc 8b00b5	

#display cmd duration, but only if the previous command exceeded 5000ms
    
	set -l limit 5000
   	 if test $CMD_DURATION 
    		set duration (echo "$CMD_DURATION 1000" | awk '{printf "%.1fs", $1 / $2}')

		set_color -o $retc
        	test $limit -lt $CMD_DURATION; and echo $duration

    	  end
				  
# and now the actual prompt to be displayed
    
     
     set_color -o $retc
     echo -n $Lfade
     set_color ffffff -b $retc	
     echo -n ' ♪ ♫ ♬ ♫ ♬ ♪ '
     set_color normal
     set_color $retc
     echo -n $Rfade
     set_color normal
end
