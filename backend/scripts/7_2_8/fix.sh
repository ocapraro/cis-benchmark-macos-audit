for dir in $(getent passwd | cut -d: -f6); do if [ ! -d "$dir" ]; then mkdir -p "$dir"; chown $(basename $dir) "$dir"; chmod 750 "$dir"; fi; done; exit 0;
