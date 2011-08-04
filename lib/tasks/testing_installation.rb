#!/usr/bin/env bash

#rm easy_data-0.0.2.gem
gem build easy_data.gemspec
gem uninstall easy_data
gem install ./easy_data-0.0.3.gem
