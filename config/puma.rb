workers Integer(ENV['PUMA_WORKER'] || 0)
threads 0, 2

bind 'tcp://0.0.0.0:8080'
