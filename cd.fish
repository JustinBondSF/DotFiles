# Defined in /var/folders/7w/8kyl32496f5c3c432t186kjh0000gn/T//fish.G5hnul/cd.fish @ line 2
function cd --wraps='cd && ls -a' --description 'alias cd & ls -a'
 builtin cd $argv && ls -a (pwd);
end
