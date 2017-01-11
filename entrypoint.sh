#!/bin/bash

PLATFORM=$(ruby -e "print RUBY_PLATFORM")

bundle exec puma -C config/puma.rb
