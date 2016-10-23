#!/usr/bin/env bash

################################################################################
# Script setup
################################################################################
function new_section ()
{
    eval printf -v line '%.0s#' {1..80}
    printf "%s\n" $line
    printf "# %s\n" "$1"
    printf "%s\n\n" $line
}

function new_subsection ()
{
    eval printf -v line '%.0s-' {1..40}
    printf "%s\n" $line
    printf "# %s\n" "$1"
    printf "%s\n\n" $line
}

################################################################################

new_section "User Information"
    
    new_subsection "whoami"
    whoami

    new_subsection "id"
    id

################################################################################

new_section "Operating System Information"

    # What's printed at the login prompt?
    new_subsection "cat /etc/issue"
    cat /etc/issue

    # Kernel version
    new_subsection "uname -a"
    uname -a

################################################################################

new_section "File Systems"

    new_subsection "mount -l"
    mount -l

    new_subsection "cat /etc/fstab"
    cat /etc/fstab

################################################################################

new_section "Networking"

    new_subsection "ifconfig -a"
    ifconfig -a

    new_subsection "cat /etc/hosts"
    cat /etc/hosts

    new_subsection "netstat -tulnpe"
    netstat -tulnpe

################################################################################

new_section "Programs and Processes"

    new_subsection "ps -efjH"
    ps -efjH

    new_subsection "dpkg -l"
    dpkg -l

################################################################################

new_section "Interesting Files"

    new_subsection "SUID and GUID files"
    find / -type f -perm -u=s -o -type f -perm -g=s -ls 2>/dev/null

    new_subsection "SUID and GUID writeable"
    find / -group `id -g` -perm -g=w -perm -u=s \
           -o -perm -o=w -perm -u=s \
           -o -perm -ow -perm -g=s \
           -ls 2>/dev/null

    new_subsection "Readable files in /etc"
    find /etc -user `id -u` -perm -u=r \
              -o -group `id -g` -perm -g=r \
              -o -perm -o=r \
              -ls 2>/dev/null

    new_subsection "Writeable files outside HOME"
    find / -path "$HOME" -prune \
           -o -path /proc -prune \
           -o \( ! -type l \) \
                -a \( -user `id -u` -perm -u=w -o -group `id -g` -perm -g=w -o -perm -o=w \) \
           -ls 2>/dev/null

################################################################################

new_section "Cron"

    new_subsection "Scheduled Jobs"
    find /etc/cron* -ls 2>/dev/null
    find /var/spool/cron* -ls 2>/dev/null


