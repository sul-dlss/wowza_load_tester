#!/usr/bin/env ruby

# This script is modified from the s3tester.rb script that Carrick Rodgers of Indiana University/Avalon wrote.
# The script hits multiple wowza pages and tests time based media time by monitoring console status
# To run this script:
#  1. Ensure all the gems listed below as require are installed (used gem install)
#  3. Put the urls you want to test in the url_list variable
#  4. Set the max number of simultaneous connections you want in the simultaneous_connections variable, default is to run the entire url list at once
#  5. Run from console via `ruby load_tester.rb`



require 'capybara'              # gem install capybara
require 'capybara/dsl'
require 'selenium-webdriver'    # gem install selenium-webdriver
require 'parallel'              # gem install parallel
#require 'pry-byebug'           # gem install byebug (only for debugging)

include Capybara::DSL # no install required, I'm just being bad here with a global scope


url_list = %w( http://sul-wowza-dev.stanford.edu/load/dd077sy6862_sl.html
               http://sul-wowza-dev.stanford.edu/load/mm912qx1890_sl.html
               http://sul-wowza-dev.stanford.edu/load/xf707my5724_sl.html
               http://sul-wowza-dev.stanford.edu/load/zw734px9641_sl.html
               http://sul-wowza-dev.stanford.edu/load/fz785wr9964_em_sl.html
               
               http://sul-wowza-dev.stanford.edu/load/dd077sy6862_sl.html
               http://sul-wowza-dev.stanford.edu/load/mm912qx1890_sl.html
               http://sul-wowza-dev.stanford.edu/load/xf707my5724_sl.html
               http://sul-wowza-dev.stanford.edu/load/zw734px9641_sl.html
               http://sul-wowza-dev.stanford.edu/load/fz785wr9964_em_sl.html
             )
simultaneous_connections = url_list.size

Capybara.configure do |c|
  c.default_driver = :selenium
  c.javascript_driver = :selenium
end

results = Parallel.map(url_list.shuffle, in_processes: simultaneous_connections) do |target_page|
  visit target_page
  start_time = Time.now
  loaded = false

  find('#video_element').click

  # These <p> elements are updated by the JavaScript that runs on the page when it's first loaded and then when the HTML5 play event is fired.
  load_time_element = find('#load_time')
  play_time_element = find("#play_time")

  load_time_in_seconds = (Integer(play_time_element.text) - Integer(load_time_element.text)) / 1000.0
  { url: target_page, load_time_in_seconds: load_time_in_seconds, request_time: start_time }
end

puts "\nResults"
puts results
