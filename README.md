# Gitlab Slack Notifier
Send a reminder to a Slack channel with a list of open GitLab merge requests waiting for someone to merge them. You can define a list of groups to monitor, so that no merge requests sink into oblivion anymore.

The list of notifications will look like this:
```markdown
### Open Merge Requests - 15 November
If you are still working on a merge request, mark it as WIP and it will not appear in the list.

:closed_book:[Resolve "Fix checkout bug"](https://www.gitlab.com/example/checkout/merge_requests/1) - Updated by John Smith 12 days ago, no assignees yet
:orange_book:[Resolve "Add button to wishlist"](https://www.gitlab.com/example/wishlist/merge_requests/2) - Updated by John Smith 3 days ago, assigned to Nick Carter
:green_book:[Resolve "Update styles.less"](https://www.gitlab.com/example/wishlist/merge_requests/3) - Updated by Nick Carter 1 day ago, no assignees yet
```

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