# frozen_string_literal: true

require 'date'

# Docs: https://docs.gitlab.com/ee/api/merge_requests.html#list-group-merge-requests
class MergeRequest
  attr_reader :title,
              :author,
              :web_url,
              :description

  def initialize(options = {})
    @title = options[:title]
    @state = options[:state]
    @author = options[:author]
    @web_url = options[:web_url]
    @assignees = options[:assignees]
    @updated_at = options[:updated_at]
    @description = options[:description]
    @merge_status = options[:merge_status]
    @work_in_progress = options[:work_in_progress]
  end

  # Return a comma separated list of the MR assignees.
  def assignees
    @assignees == [] ? nil : @assignees.map { |a| a['name'] }.join(', ')
  end

  # Check if the merge request can be merged.
  def can_be_merged?
    @merge_status == 'can_be_merged'
  end

  # Check if the merge request is a work in progress.
  def wip?
    @work_in_progress
  end

  # The number of days the merge request is waiting to be merged.
  def waiting_days
    updated_at = Date.parse(@updated_at)
    (Date.today - updated_at).to_i
  end

  # Format a merge request as a Markdown one-liner.
  def to_markdown
    message = "#{importance_emoji} [#{title}](#{web_url}) - " \
    "Author: #{author}, updated #{updated_string}"
    message += ", assigned to #{assignees}" if assignees
    message += ' :no_entry_sign: cannot be merged' unless can_be_merged?
    message + "\n"
  end

  # Get the updated_at time from now as a string (e.g. "2 days ago").
  def updated_string
    return 'today' if waiting_days.zero?

    waiting_days == 1 ? 'yesterday' : "#{waiting_days} days ago"
  end

  # Get the appropriate importance emoji for the merge request.
  def importance_emoji
    if waiting_days <= 1
      ':green_book:'
    elsif waiting_days > 1 && waiting_days < 7
      ':orange_book:'
    else
      ':closed_book:'
    end
  end
end
