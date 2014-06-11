APP_PATH = "/home/neves/photoCMS"
preload_app true
working_directory APP_PATH
pid APP_PATH + "/tmp/pids/unicorn.pid"
listen 8008
worker_processes 8
timeout 60
