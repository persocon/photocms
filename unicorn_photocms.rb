app_name = "photo-cms"
rack_env = (ENV['RACK_ENV'] || :production).to_sym
puts "Starting app in #{rack_env} mode..."
APP_PATH = "/var/www/#{app_name}"
if rack_env == :production
  working_directory APP_PATH
  worker_processes 4
else
  working_directory "."
  worker_processes 1
end

listen "/tmp/#{app_name}.sock", :backlog => 64
listen 8008, :tcp_nopush => true

pid APP_PATH + "/tmp/pids/unicorn.pid"

preload_app true


timeout 60

stderr_path "./log/unicorn.stderr.log"
stdout_path "./log/unicorn.stdout.log"

before_fork do |server, worker|
	old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  # Save pids for monit's sake
  child_pid = server.config[:pid].sub('.pid', ".#{worker.nr}.pid")
  system("echo #{Process.pid} > #{child_pid}")
end
