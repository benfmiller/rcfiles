#!/usr/bin/env sh
export BORG_REPO=/mnt/BigData/backupdata/borg
export BORG_PASSPHRASE=`cat /root/.borg_password`

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Starting backup"

borg create \
    --verbose --progress \
    --filter AME \
    --stats --show-rc \
    --compression zlib,5 \
    --exclude-caches \
    ::"{hostname}-monthly-{now}" \
    /mnt/NAS/Pictures \
    /mnt/NAS/Music \
    /mnt/NAS/Books \
    /mnt/BigData/MoviesAndShows


backup_exit=$?

info "Pruning repository"

# prune the repo
borg prune \
    --list \
    --prefix '{hostname}-monthly-' \
    --show-rc \
    --keep-daily 5 \
    --keep-weekly 3 \
    --keep-monthly 2 2>&1

prune_exit=$?

# use highest exit code as exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 1 ];
then
    info "Backup and/or Prune finished with a warning"
fi

if [ ${global_exit} -gt 1 ];
then
    info "Backup and/or Prune finished with an error"
fi

exit ${global_exit}
