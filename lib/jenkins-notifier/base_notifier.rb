module JenkinsNotifier
  class BaseNotifier
    class NotifierUnavailable < RuntimeError; end

    def self.raise_unless_available
      raise NotifierUnavailable unless available?
    end

    def self.available?
      @available ||= (not `which #{command}`.empty?)
    end

    def initialize(job, build_status)
      @presenter = Presenter.new(job, build_status)
    end
  end
end
