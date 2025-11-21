ps -eZ | grep unconfined_service_t | grep -q . && exit 1 || exit 0
