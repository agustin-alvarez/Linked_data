#!/usr/bin/env bash

rm easy_data3-0.0.*
gem build easy_data.gemspec
gem uninstall easy_data3
gem install ./easy_data3-*.gem
