# Defined in - @ line 1
function genmac
    openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//' $argv

end
