module JenkinsNotifier
  class Presenter
    def initialize(job, build_status)
      @job = job
      @build_status = build_status
    end

    def summary
      "#{@job.nickname} ##{@build_status.number} #{@build_status.to_sym}"
    end
    alias_method :title, :summary

    def body
      changeset
    end
    alias_method :message, :body

    def icon_pathname
      if @build_status.success?
        Images.success_pathname
      elsif @build_status.building?
        Images.building_pathname
      elsif @build_status.aborted?
        Images.aborted_pathname
      else
        Images.failure_pathname
      end
    end

    def changeset
      @build_status.changeset["items"].map { |item| "#{bullet} #{item["comment"]}" }.join
    end

    def bullet
      "\u2022"
    end

    def url
      "#{Config.uri}job/#{@job.name}/#{@build_status.number}/console"
    end
  end
end
