# frozen_string_literal: true

module ToDo
  #
  # Relies on pandoc to generate HTML out from a Github flavored markdown file.
  # https://pandoc.org/installing.html
  #
  class Visualizer
    CSS_URL = 'https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/4.0.0/github-markdown.min.css'
    BODY_CSS = <<~CSS
      max-width: 700px;
      margin: 40px auto;
    CSS

    attr_reader :context

    def initialize(context)
      @context = context
    end

    def view
      exit_and_install_pandoc unless system('command -v pandoc', out: ['/dev/null'])
      raise 'Something failed with Pandoc' unless system(command)

      update_body_class
      system("open #{tmpfile}")
    end

    private

    def command
      [
        "pandoc #{context.file_path}",
        '-f gfm',
        '-s',
        "-o #{tmpfile}",
        '--metadata title="TODO"',
        "-c #{CSS_URL}"
      ].join(' ')
    end

    def exit_and_install_pandoc
      puts 'Please install pandoc first. https://pandoc.org/installing.html'
      exit 1
    end

    def tmpfile
      "#{File.join(Dir.tmpdir, context.file_name)}.html"
    end

    # TODO: This can be updated to just modify the body tag
    def update_body_class
      html = File.read(tmpfile)
      html.sub!('<body>', "<body class='markdown-body' style='#{BODY_CSS}'>")
      File.open(tmpfile, 'wb') { |f| f.puts(html) }
    end
  end
end
