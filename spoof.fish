# Defined in - @ line 1
function spoof --wraps='sudo spoof randomize en0' --description 'alias spoof sudo spoof randomize en0'
  sudo spoof randomize en0 $argv;
end
