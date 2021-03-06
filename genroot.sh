function genroot {
    if [[ -d $1/root/dev ]]; then
         root="$1/root"
    elif [[ -d $1/@/dev ]]; then
         root="$1/@"
    else
         root="$1"
    fi

    if ! [[ -f "$root/proc/cpuinfo" ]]; then
         sudo mount -t proc /proc "$root/proc"
         sudo mount --rbind /dev "$root/dev"
         sudo mount --make-rslave "$root/dev"
         sudo mount --rbind /sys "$root/sys"
         sudo mount --make-rslave "$root/sys"
         sudo rm "$root/etc/resolv.conf"
         sudo cp -L /etc/resolv.conf "$root/etc"
    fi

    if [[ -f $root/bin/env ]]; then
         ENV=/bin/env
    elif [[ -f $root/usr/bin/env ]]; then
         ENV=/usr/bin/env
    fi

    if [[ -f $root/usr/local/bin/su-fusion809 ]]; then
         sudo chroot "$root" /usr/local/bin/su-fusion809
    elif [[ -f $root/bin/zsh ]]; then
         sudo chroot "$root" $ENV -i     \
               HOME="/root"              \
               TERM="$TERM"              \
               PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;31m\]\$\[\e[m\] \['            \
               PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin \
               /bin/zsh --login +h
    elif [[ -f $root/bin/bash ]]; then
         sudo chroot "$root" $ENV -i     \
               HOME="/root"              \
               TERM="$TERM"              \
               PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;31m\]\$\[\e[m\] \['            \
               PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin \
               /bin/bash --login +h
    elif [[ -f $root/bin/sh ]] && [[ -n $ENV ]]; then
         sudo chroot "$root" $ENV -i     \
               HOME="/root"              \
               TERM="$TERM"              \
               PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;31m\]\$\[\e[m\] \['            \
               PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin \
               /bin/sh --login +h
    elif [[ -f $root/bin/sh ]] || [[ -L $root/bin/sh ]]; then
         sudo chroot "$root" /bin/sh
    else
         printf "I'm missing a shell, mate!"
    fi

    if [[ -f $root/usr/bin/dnf ]]; then
         sudo touch "$root/.autorelabel"
    fi
}
