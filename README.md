# GitLab Slack Notifier
[![Build Status](https://travis-ci.com/gpaddis/gitlab-slack-notifier.svg?branch=master)](https://travis-ci.com/gpaddis/gitlab-slack-notifier)

Send a reminder to a Slack channel with a list of open GitLab merge requests waiting for someone to merge them. You can define a list of groups to monitor, so that no merge requests sink into oblivion anymore.

The list of merge requests will look like this:

---
> ### Open Merge Requests - 15 November
> If you are still working on a merge request, mark it as WIP and it will not appear in the list.
>
> :closed_book: [Resolve "Fix checkout bug"](https://www.gitlab.com/example/checkout/merge_requests/1) - Author: John Smith, updated 12 days ago<br>
> :orange_book: [Resolve "Add button to wishlist"](https://www.gitlab.com/example/wishlist/merge_requests/2) - Author: John Smith, updated 3 days ago, assigned to Nick Carter<br>
> :green_book: [Resolve "Update styles.less"](https://www.gitlab.com/example/wishlist/merge_requests/3) - Author: Nick Carter, updated yesterday :no_entry_sign: cannot be merged<br>

---

The merge requests are sorted by date (older first) and marked with :green_book: (up to 1 day), :orange_book: (up to a week) or :closed_book: (older than a week). WIP MRs are not shown.

This project was inspired by [slack-gitlab-mr-reminder](https://github.com/monokh/slack-gitlab-mr-reminder).

## Requirements
* A GitLab API Token
* A Slack / [Mattermost](https://mattermost.com/) Webhook URL

## Setup
Clone the repository and install the dependencies:
```
bundle
```
Copy the configuration file in the script directory:
```
cp config.example.json config.json
```
Edit the file and set the correct values, then run the notifier script:
```
./notifier
```
You will receive a notification in your Slack channel with the list of open merge requests.

## Tests
Run `bundle exec guard` to keep the test suite running in watch mode.
