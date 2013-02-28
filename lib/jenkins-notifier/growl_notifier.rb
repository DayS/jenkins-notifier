module JenkinsNotifier
  class GrowlNotifier < BaseNotifier
    def self.command
      "growlnotify"
    end

    def notify
      Thread.new do
        `#{self.class.command} -w --image "#{@presenter.icon_pathname}" --message "#{@presenter.message}" --title "#{@presenter.title}"`

        # growlnotify returns exit code 2 if the notification is clicked
        if $?.exitstatus == 2
          `open #{@presenter.url}`
        end
      end
    end
  end
end
