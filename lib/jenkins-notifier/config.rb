module JenkinsNotifier
  module Config
    class << self
      attr_accessor :config_name
    end

    self.config_name = :default

    def self.jobs
      raise(ArgumentError, "jobs") if config["jobs"].nil?

      config["jobs"].map do |job|
        statuses = if job["statuses"]
                     job["statuses"].map { |status| BuildStatus.new(status) }
                   else
                     self.statuses
                   end
        Job.new(job["name"], job["nickname"], statuses)
      end
    end

    def self.statuses
      raise(ArgumentError, "statuses") if config["statuses"].nil?

      config["statuses"].map { |status| BuildStatus.new(status) }
    end

    def self.uri
      raise(ArgumentError, "url") if config["url"].nil?

      URI(config["url"])
    end

    def self.interval
      config["interval"] || 30
    end

    def self.notifier
      case config["notifier"]
      when "ubuntu" then UbuntuNotifier
      when "growl"  then GrowlNotifier
      else               raise(ArgumentError, "notifier")
      end
    end

    def self.config
      @config ||= load_config
    end

    def self.load_config
      YAML.load(config_pathname.read)
    end

    def self.config_pathname
      root_pathname + "config/#{config_name}.yml"
    end

    def self.root_pathname
      Pathname.new(__FILE__).dirname + "../.."
    end
  end
end
