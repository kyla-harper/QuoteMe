# frozen_string_literal: false

desc 'Run the bot'
task :run do
  # rubocop:disable Style/RedundantBegin
  begin
    sh 'bundle exec ruby lib/quote_me.rb'
  rescue Interrupt
    exit
  end
  # rubocop:enable Style/RedundantBegin
end

task :cmd_markdown do
  require 'ostruct'
  require 'yaml'

  commands = OpenStruct.new YAML.load_file 'lib/data/commands.yml'
  markdown_string = ''
  markdown_string << "|command|aliases|description|usage|\n"
  markdown_string << "|---|---|---|---|\n"
  commands.each_pair.each do |command|
    markdown_string << "|`#{command.first}`|"
    markdown_string << if command.last['aliases'].empty?
                         'none'
                       else
                         "`#{command.last['aliases'].join('`, `')}`"
                       end
    markdown_string << "|#{command.last['description']}"
    markdown_string << "|`#{command.last['usage']}`|\n"
  end
  File.open('commands.md', 'w') { |file| file.write markdown_string }
end
