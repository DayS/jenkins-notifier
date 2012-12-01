module JenkinsNotifier
  class Job
    include Logger

    attr_reader :name,
                :nickname

    def initialize(name, nickname, statuses)
      @name = name
      @nickname = nickname || @name
      @statuses = statuses

      @last_build_status = BuildStatus.new
      @current_build_status = BuildStatus.new
    end

    def changed?
      (@current_build_status != @last_build_status).tap do |changed|
        changed ? log("changed") : log("not changed")
      end
    end

    def notify(notifier)
      if @statuses.include? @current_build_status
        log "notifying"
      else
        log "ignoring"
        return
      end

      notifier = notifier.new(self, @current_build_status)
      notifier.notify
    end

    def update_current_build_status
      log "updating current build status"
      @current_build_status = Jenkins.last_build_status(self)
    end

    def update_last_build_status
      @last_build_status = @current_build_status
    end

    def log(message)
      logger.debug "#{@nickname}: #{message}"
    end
  end
end

