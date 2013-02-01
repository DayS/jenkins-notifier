module JenkinsNotifier
  module Jenkins
    extend Logger

    def self.last_build_status(job)
      api = parse_uri(last_build_status_uri(job))

      api ? BuildStatus.from_api(api) : BuildStatus.new
    end

    def self.last_build_status_uri(job)
      Config.uri + "job/#{job.name}/lastBuild/api/json"
    end

    def self.build_status(job, build_number)
      api = parse_uri(build_status_uri(job, build_number))

      api ? BuildStatus.from_api(api) : BuildStatus.new
    end

    def self.parse_uri(uri)
      response = read_uri(uri)
      return if response.nil?

      JSON.parse(response)
    end

    def self.read_uri(uri)
      logger.debug("Jenkins") { "reading #{uri}" }
      begin
        open(uri).read
      rescue OpenURI::HTTPError => exception
        logger.warn("Jenkins") { "exception raised: #{exception.class.name}: #{exception.message}" }

        nil
      end
    end

    def self.build_status_uri(job, build_number)
      Config.uri + "job/#{job.name}/#{build_number}/api/json"
    end
  end
end
