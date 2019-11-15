# Gitlab Slack Notifier
Send a reminder to a Slack channel with a list of open GitLab merge requests waiting for someone to merge them.

This project was inspired by [slack-gitlab-mr-reminder](https://github.com/monokh/slack-gitlab-mr-reminder).

## Requirements
* A GitLab API Token
* A Slack / Mattermost Webhook URL

## Setup
Copy the configuration file in the script directory:
```
cp config.example.json config.json
```
Edit the file and set the correct values, then run the notifier script:
```
./notifier
```
You will receive a notificaiton in your Slack channel with the list of open merge requests sorted by date.

## Tests
Run `bundle exec guard` to keep the test suite running in watch mode.