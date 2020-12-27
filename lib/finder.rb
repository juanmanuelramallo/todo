# frozen_string_literal: true

module ToDo
  #
  # Finds text in to-dos entries. Relies on system's `find' and `grep' commands.
  #
  class Finder
    attr_reader :context, :query

    def initialize(context:, query:)
      @context = context
      @query = query
    end

    def find
      system("find #{context.dir_path} -type f | xargs grep -Hni \"#{query}\"")
    end
  end
end
