module ToDo
  class Parser
    Options = Struct.new(:date, :yesterday, :query, :visualize)

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
            todo -y, --yesterday        # Open todo yesterday
            todo                        # Open todo for today
            todo -f, --find algo        # Looks for todo with word "algo"
            todo -v, --visualize        # Opens an HTML file with the to-dos

        TXT

        parser.on("-dDATE", "--date=DATE", "Todo's date") do |d|
          options.date = d
        end

        parser.on('-y', '--yesterday', "Todo's for yesterday") do |y|
          options.yesterday = y
        end

        parser.on('-fQUERY', '--find=QUERY', 'Looks for query') do |q|
          options.query = q
        end

        parser.on('-v', '--visualize', 'Visualize a todo list') do |v|
          options.visualize = v
        end

        parser.parse!(args)
      end

      parse_date!

      options
    end

    private

    def options
      @options ||= Options.new
    end

    def parse_date!
      options.date = options.yesterday ? (Date.today - 1) : nil
      options.date ||= case options.date
      when /[0-9]{4}-[0-9]{2}-[0-9]{2}/
        Date.parse(options.date)
      when nil, ''
        Date.today
      else
        raise 'WAT'
      end
    end
  end
end

