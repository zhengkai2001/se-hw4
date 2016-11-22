require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

Given(/^the following movies exist:$/) do |movies_table|
  DatabaseCleaner.clean
  movies_table.hashes.each do |movie|
    Movie.create! movie
  end
end

Then(/^the director of "([^"]*)" should be "([^"]*)"$/) do |title, director|
  @movie=Movie.where(title: title).first
  expect(@movie.director).to eql director
end

Then /^(?:|I )should see "([^"]*)" ordering "([^"]*)"$/ do |title, order|
  page.should have_xpath("//tbody/tr[#{order}]/td[1]/text()", :text => title)
end

When /^(?:|I )uncheck the option with ID "([^"]*)"$/ do |field|
  uncheck(field)
end