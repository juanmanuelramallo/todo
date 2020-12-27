module ToDo
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
