# jenkins-notifier

Polls Jenkins jobs for changes, then uses Growl or Ubuntu's notifier.

<img src="http://f.cl.ly/items/3l1K0N443I3l3x2n013z/jenkins-notifier.png">

## Dependencies

* Ruby 1.9
* Mac OS X: [Growl](http://growl.info/) with [growlnotify](http://growl.info/extras.php#growlnotify) \[[1.2](https://github.com/paperlesspost/jenkins-notifier/blob/master/setup/growlnotify-1.2.pkg)\] \[[1.3](https://github.com/paperlesspost/jenkins-notifier/blob/master/setup/growlnotify-1.3.zip)\]
* Ubuntu: [notify-send](http://manpages.ubuntu.com/manpages/gutsy/man1/notify-send.1.html) (ships with 12.04)

## Installation

  1. Clone the repository:

    ```
    $ git clone git://github.com/paperlesspost/jenkins-notifier.git
    ```

  2. Create a `default.yml` configuration file (see below)

  3. Start the service:

    ```
    $ bin/jenkins-notifier
    ```

## Configuration

Please copy `default.yml.example` to `default.yml` to get started.

<dl>
  <dt>url</dt>
  <dd>The URL of your Jenkins installation.</dd>

  <dt>statuses<dt>
  <dd>The statuses to be notified of. Can be placed at the root-level (applies to all jobs), or at the job-level (in case you wish to be notified of more or fewer statuses for a specific job).

  <dt>interval</dt>
  <dd>The polling interval.</dd>

  <dt>notifier</dt>
  <dd>The notifier to use. Choices are: <code>growl</code> or <code>ubuntu</code>.</dd>

  <dt>jobs</dt>
  <dd>The jobs to poll. A <code>name</code> is required, and must match what's in Jenkins. A <code>nickname</code> is optional, and is used in the notifications.
</dl>
