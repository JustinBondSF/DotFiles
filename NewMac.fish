# Defined in - @ line 1
function genmac --wraps=openssl\ rand\ -hex\ 6\ \|\ sed\ \'s/\\\(..\\\)/\\1:/g\;\ s/.\$//\' --description alias\ NewMac\ openssl\ rand\ -hex\ 6\ \|\ sed\ \'s/\\\(..\\\)/\\1:/g\;\ s/.\$//\'
    openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//' $argv
end
