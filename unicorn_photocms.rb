APP_PATH = "/var/www/api.elsif.io"
preload_app true
working_directory APP_PATH
pid APP_PATH + "/tmp/pids/unicorn.pid"
listen 8008
worker_processes 4
timeout 60
