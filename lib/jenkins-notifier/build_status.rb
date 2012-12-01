module JenkinsNotifier
  class BuildStatus
    STATUSES = [:success, :failure, :aborted, :building, :unknown]

    STATUSES.each do |status|
      define_singleton_method(status) do
        new(status)
      end
    end

    def self.from_api(api)
      name = if api["building"]
               building
             else
               case api["result"]
               when "SUCCESS" then success
               when "FAILURE" then failure
               when "ABORTED" then aborted
               else                unknown
               end
             end

      new(name, api)
    end

    def initialize(name = :unknown, api = Hash.new)
      name = name.to_sym
      raise ArgumentError unless STATUSES.include?(name)

      @name = name
      @api = api
    end

    STATUSES.each do |status|
      define_method("#{status}?") do
        self.to_sym == status
      end
    end

    def to_sym
      @name
    end

    def id
      @api["id"]
    end

    def number
      @api["number"].to_i
    end

    def changeset
      @api["changeSet"]
    end

    # Returns true if two build statuses are considered equivalent, false if
    # not.
    def ==(build_status)
      # If both statuses have an ID, use it in the comparison.
      if id and build_status.id
        [id, self.to_sym] == [build_status.id, build_status.to_sym]
      # If not, fall back to comparing them by name only.
      else
        self.to_sym == build_status.to_sym
      end
    end
  end
end
