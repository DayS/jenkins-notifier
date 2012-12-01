module JenkinsNotifier
  class UbuntuNotifier < BaseNotifier
    def self.command
      "notify-send"
    end

    def notify
      `#{self.class.command} --icon "#{@presenter.icon_pathname}" "#{@presenter.summary}" "#{@presenter.body}"`
    end
  end
end
