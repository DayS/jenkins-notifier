module JenkinsNotifier
  module Logger
    def logger
      if @logger.nil?
        @logger = ::Logger.new(STDOUT)
        @logger.level = ::Logger::WARN
      end

      @logger
    end
  end
end
