module JenkinsNotifier
  class Job
    include Logger

    attr_reader :name,
                :nickname

    def initialize(name, nickname, statuses)
      @name     = name
      @nickname = nickname || @name
      @statuses = statuses

      @build_statuses = BuildStatuses.new
    end

    def changed?
      changed = @build_statuses.changed?
      changed ? log("changed") : log("not changed")

      changed
    end

    def notify(notifier)
      return unless changed?

      @build_statuses.changed.each do |build_status|
        if notify?(build_status)
          log "notifying"
        else
          log "ignoring"
          next
        end

        notifier.new(self, build_status).notify
      end
    end

    def notify?(build_status)
      @statuses.include?(build_status)
    end

    # Resets the build statuses instance. Called after all notifications have
    # been sent.
    def reset_build_statuses
      @build_statuses.reset
    end

    # Shovels the last *and* next-to-last build statuses into the
    # BuildStatuses instance. The reason the next-to-last build status is
    # needed is to capture the state of a job that transitions from one build
    # immediately to the next (please see issue #3).
    def update_build_statuses
      log "updating build statuses"
      last_build_status = Jenkins.last_build_status(self)
      @build_statuses << last_build_status
      @build_statuses << previous_build_status(last_build_status)
    end

    def previous_build_status(build_status)
      build_number = build_status.previous_number

      previous_build_status = Jenkins.build_status(self, build_number) if build_number
    end

    def log(message)
      logger.debug(@nickname) { message }
    end
  end
end

