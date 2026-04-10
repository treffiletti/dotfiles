function reset-displays --description 'Reset macOS display/WindowServer preferences and cache (will log you out)'
    echo "This will reset all display preferences and log you out. Continue? (y/n)"
    read -n1 -l confirm
    echo ""

    if test "$confirm" != y -a "$confirm" != Y
        echo "Cancelled."
        return
    end

    # Remove global WindowServer preferences
    sudo rm -f /Library/Preferences/com.apple.windowserver*.plist

    # Remove WindowServer cache/database
    sudo rm -rf /private/var/db/WindowServer

    # Remove user-specific display profiles
    rm -f ~/Library/Preferences/ByHost/com.apple.windowserver.displays*.plist 2>/dev/null

    # Remove ColorSync profiles linked to displays
    sudo rm -rf ~/Library/ColorSync/Profiles/ByHost
    sudo rm -rf /Library/ColorSync/Profiles/Displays 2>/dev/null

    # Restart display services (this will log you out)
    sudo killall -HUP WindowServer
end
