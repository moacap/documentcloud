namespace :ping do

  task :stop do
    sh "kill `cat log/pixel_ping.pid`; rm log/pixel_ping.pid"
  end

  task :run do
    sh launch_command
  end

  task :start do
    sh "nohup #{launch_command} > log/pixel_ping.log 2>&1 & echo $! > log/pixel_ping.pid"
  end

  task :restart => [:stop, :start]

end

def launch_command
  "node ../pixel-ping/lib/pixel-ping.js config/pixel_ping/#{RAILS_ENV}.json"
end
