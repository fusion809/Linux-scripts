function datsp {
    df -h /dev/sdb1
}

function space {
    SHOW=$(sudo btrfs fi show | head -n 3 | grep "devid")
    USED=$(echo $SHOW| cut -d ' ' -f 9)
    AVAIL=$(echo $SHOW | cut -d ' ' -f 7)

    printf "$USED/$AVAIL used\n"
}

