# frozen_string_literal: true

module ToDo
  #
  # Creates or reopens a to-do file for the given date.
  #
  class Session
    # TODO: Add support for custom templates
    TEMPLATE = ERB.new(<<~ERB).freeze
      # <%= @date %>

      ## To-do
        -
      ## Plan
        -
      ## Questions
        -
    ERB

    attr_reader :context

    def initialize(context)
      @context = context
      @date = context.options.date

      Dir.mkdir(context.dir_path) unless Dir[context.dir_path].any?
      prepare_todo_file
    end

    def start
      exit_and_set_editor unless system("command -v #{context.editor}", out: ['/dev/null'])
      system("#{context.editor} #{context.file_path}")
    end

    private

    def exit_and_set_editor
      puts "#{context.editor} not found" if context.editor
      puts "Please set an editor to use with `todo -e EDITOR'. Check `todo -h' for more info."
      exit 1
    end

    def prepare_todo_file
      return if Dir[context.file_path].any?

      File.open(context.file_path, 'w') do |f|
        f.puts TEMPLATE.result(self.binding)
      end
    end
  end
end
