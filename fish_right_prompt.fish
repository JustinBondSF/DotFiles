# Defined in /tmp/fish.EwS3o9/fish_right_prompt.fish @ line 2
function fish_right_prompt

#create glyph references, color the output based on [ret]urn [c]ode aka prev cmd success or fail
    set -U Rseperator \uE0C8
    set -U Lseperator \uE0CA
	set -U Rfade ▓▒░
	set -U Lfade ░▒▓ 	   
	set -l  retc ff0000
	test $status = 0; and set -l retc 8b00b5	

#display cmd duration, but only if the previous command exceeded 5000ms
    
set prev_cmd_duration	(set -l limit 5000
   	            if test $CMD_DURATION 
    		      set duration (echo "$CMD_DURATION 1000" | awk '{printf "%.1fs", $1 / $2}')

        	       test $limit -lt $CMD_DURATION
end
				  )
# and now the actual prompt to be displayed
    
     
     set_color -o $retc
     echo -n $Lfade
     set_color ffffff -b $retc	
     echo -n ' ♪ ♫ ♬'
     echo -n $prev_cmd_duration
     echo -n ' ♫ ♬ ♪ '
     set_color normal
     set_color $retc
     echo -n $Rfade
     set_color normal
end
