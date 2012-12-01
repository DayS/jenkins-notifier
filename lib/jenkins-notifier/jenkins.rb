module JenkinsNotifier
  module Jenkins
    def self.last_build_status(job)
      response = open(last_build_status_uri(job)).read
      api = JSON.parse(response)

      BuildStatus.from_api(api)
    end

    def self.last_build_status_uri(job)
      Config.uri + "job/#{job.name}/lastBuild/api/json"
    end
  end
end
