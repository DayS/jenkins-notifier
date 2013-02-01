module JenkinsNotifier
  class BuildStatuses
    include Logger

    STATUSES_TO_PERSIST = 2

    def initialize
      @current_statuses = Array.new
      reset
    end

    def <<(build_status)
      return if build_status.nil?

      @current_statuses = (@current_statuses |= [build_status])
    end

    def changed
      log_statuses("Current statuses", @current_statuses)
      log_statuses("Previous statuses", @previous_statuses)

      (@current_statuses - @previous_statuses)
    end

    def changed?
      not changed.empty?
    end

    def log_statuses(label, statuses)
      logger.debug(label) do
        statuses.map { |status| "#{status.id} #{status.to_sym}" unless status.nil? }
      end
    end

    def reset
      @previous_statuses = Array.new
      STATUSES_TO_PERSIST.times.map { @previous_statuses.unshift(@current_statuses.pop) }
      @current_statuses = Array.new
    end
  end # BuildStatuses
end # JenkinsNotifier
