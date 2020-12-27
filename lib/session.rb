module ToDo
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
      system("$EDITOR #{context.file_path}")
    end

    private

    def prepare_todo_file
      return if Dir[context.file_path].any?

      File.open(context.file_path, 'w') do |f|
        f.puts TEMPLATE.result(self.binding)
      end
    end
  end
end
