function macspoof
    echo 'Spoofing MAC...'

    sudo ifconfig en0 ether (genmac)
    sleep 5
    echo 'MAC Address Successfully Spoofed! Restarting Wi-Fi...'

    sleep 2
    echo 'Your New MAC:'
    sudo ifconfig en0 | grep ether
end