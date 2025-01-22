function rm -w trash -d "Move file or directory to the trash"
    if type -q trash
        command trash -s $argv
    else
        echo "command `trash` not found"
    end
end
