#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.

if ENV['RACK_ENV'] == 'production' 
  require 'unicorn/worker_killer'

  max_request_min =  500
  max_request_max =  600

  # Max requests per worker
  use Unicorn::WorkerKiller::MaxRequests, max_request_min, max_request_max

  oom_min = (140) * (1024**2)
  oom_max = (160) * (1024**2)

  # Max memory size (RSS) per worker
  use Unicorn::WorkerKiller::Oom, oom_min, oom_max
end

require File.expand_path("../config/boot.rb", __FILE__)

run Padrino.application
