Feature: Index Scope To

  Viewing resource configs scoped to another object

  Background:
	Given 10 posts exist
	And a post with the title "Hello World" written by "John Doe" exists
	And a published post with the title "Hello World" written by "John Doe" exists
	Given an index configuration of:
	  """
	  ActiveAdmin.register Post do
		# Scope section to a specific author
		scope_to do
		  User.find_by_first_name_and_last_name("John", "Doe")
		end

		# Setup some scopes
        scope :all, :default => true
        scope :published do |posts|
          posts.where("published_at IS NOT NULL")
        end
	  end
	  """

  Scenario: Viewing the default scope counts
	When I am on the index page for posts
    Then I should see the scope "All" selected
    And I should see the scope "All" with the count 2
    And I should see 2 posts in the table
