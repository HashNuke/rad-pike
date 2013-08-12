class IssueStateType < ActiveRecord::Base
  def self.resolved
    Rails.cache.fetch('issue-state-type-resolved') do
      self.find_by_name("Resolved")
    end
  end

  def self.unresolved
    Rails.cache.fetch('issue-state-type-unresolved') do
      self.find_by_name("Unresolved")
    end
  end
end
