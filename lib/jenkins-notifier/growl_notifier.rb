module JenkinsNotifier
  class GrowlNotifier < BaseNotifier
    def self.command
      "growlnotify"
    end

    def notify
      `#{self.class.command} --icon "#{@presenter.icon_pathname}" --message "#{@presenter.message}" --title "#{@presenter.title}"`
    end
  end
end
