require "json"
require "logger"
require "open-uri"
require "yaml"
require "pathname"

require_relative "jenkins-notifier/logger"
require_relative "jenkins-notifier/config"
require_relative "jenkins-notifier/images"
require_relative "jenkins-notifier/poller"
require_relative "jenkins-notifier/job"
require_relative "jenkins-notifier/build_status"
require_relative "jenkins-notifier/presenter"
require_relative "jenkins-notifier/jenkins"
require_relative "jenkins-notifier/base_notifier"
require_relative "jenkins-notifier/growl_notifier"
require_relative "jenkins-notifier/ubuntu_notifier"

jobs = JenkinsNotifier::Config.jobs

notifier = JenkinsNotifier::Config.notifier
notifier.raise_unless_available

interval = JenkinsNotifier::Config.interval

poller = JenkinsNotifier::Poller.new(jobs, notifier, interval)
poller.start
