module JenkinsNotifier
  class Poller
    include Logger

    def initialize(jobs, notifier, interval)
      @jobs = jobs
      @notifier = notifier
      @interval = interval
    end

    def start
      while true
        @jobs.each do |job|
          begin
            job.update_current_build_status
            if job.changed?
              job.update_last_build_status
              job.notify(@notifier)
            end
          rescue Exception => exception
            logger.warn "Rescued exception while polling: #{exception.class.name}: #{exception.message}"
            logger.warn exception.backtrace.join("\n")
          end
        end
        sleep(@interval)
      end
    end
  end
end
