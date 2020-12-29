# frozen_string_literal: true

module ToDo
  #
  # OptionParser wrapper for the to-do app.
  #
  class Parser
    Options = Struct.new(:date, :editor, :yesterday, :tomorrow, :query, :visualize, keyword_init: true)

    attr_reader :args

    def initialize(args)
      @args = args
    end

    def parse
      OptionParser.new do |parser|
        parser.banner = <<~TXT
          A ruby CLI-only To Do app, because why not?
          Usage:
            todo -d, --date 2020-12-25  # Open todo for the date
            todo -e, --editor code      # Uses code as the editor. Default is $EDITOR.
            todo -y, --yesterday        # Open todo yesterday
            todo -t, --tomorrow         # Open todo for tomorrow
            todo                        # Open todo for today
            todo -f, --find algo        # Looks for todo with word "algo"
            todo -v, --visualize        # Opens an HTML file with the to-dos

        TXT

        parser.on('-t', '--tomorrow', "Todo's for tomorrow") do |t|
          options.tomorrow = t
          options.date = Date.today + 1
        end

        parser.on('-y', '--yesterday', "Todo's for yesterday") do |y|
          options.yesterday = y
          options.date = Date.today - 1
        end

        parser.on('-dDATE', '--date=DATE', "Todo's date") do |d|
          options.date = parse_date(d)
        end

        parser.on('-eEDITOR', '--editor=EDITOR', 'Editor command') do |e|
          options.editor = e
        end

        parser.on('-fQUERY', '--find=QUERY', 'Looks for query') do |q|
          options.query = q
        end

        parser.on('-v', '--visualize', 'Visualize a todo list') do |v|
          options.visualize = v
        end

        parser.on('-V', '--version', 'See the version') do |_v|
          puts VERSION
          exit 0
        end

        parser.parse!(args)
      end

      options
    end

    private

    def options
      @options ||= Options.new(date: Date.today)
    end

    def parse_date(date)
      case date
      when /[0-9]{4}-[0-9]{2}-[0-9]{2}/
        Date.parse(date)
      when nil, ''
        Date.today
      else
        raise 'WAT'
      end
    end
  end
end
