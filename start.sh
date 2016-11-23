#!/usr/bin/env bash
bundle exec rackup -p 9393 -D
QUEUE=* nohup bundle exec rake resque:work &