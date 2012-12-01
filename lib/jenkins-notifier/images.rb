module JenkinsNotifier
  module Images
    def self.success_pathname
      images_pathname + "green_heart.png"
    end

    def self.failure_pathname
      images_pathname + "broken_heart.png"
    end

    def self.building_pathname
      images_pathname + "heartbeat.png"
    end

    def self.aborted_pathname
      images_pathname + "boom.png"
    end

    def self.images_pathname
      Config.root_pathname + "images"
    end
  end
end
