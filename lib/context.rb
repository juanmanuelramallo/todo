# frozen_string_literal: true

module ToDo
  #
  # Context object that provides general info for all objects in the to-do app.
  #
  class Context
    DIR_PATH = '.todo'

    attr_reader :options

    def initialize(options)
      @options = options
    end

    def dir_path
      File.join(Dir.home, DIR_PATH)
    end

    def file_name
      "#{options.date.to_s}.md"
    end

    def file_path
      File.join(dir_path, file_name)
    end
  end
end
