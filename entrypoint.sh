#!/bin/bash

PLATFORM=$(ruby -e "print RUBY_PLATFORM")

case $PLATFORM in
	"java")
	echo "java platform!"
	bundle exec puma -C config/puma.rb
	;;
	*)
	echo "ruby platform!"
	bundle exec thin start -C config/thin.yml
	;;
esac
