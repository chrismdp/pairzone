Then /^a new pairzone is started for "([^"]*)"$/ do |developer_name|
  check_pairzone_started_for(developer_name)
end

Then /^no pairzone should be started$/ do
  assert_no_partial_output("started", all_output)
end

Then /^a new pairzone is started for "([^"]*)" in the background$/ do |developer_name|
  check_pairzone_started_for(developer_name)
  check_didnt_connect
end

Then /^the code in my current directory is pushed to the server$/ do
  look_for "pushing local code to pairzone instance"
  look_for "master -> master (forced update)" # the git printout
end

Then /^an SSH connection is made to my new pairzone$/ do
  check_attempt_connect
end

Then /^the code is downloaded to a "([^"]*)" branch when I quit the session$/ do |branch_name|
  assert_matching_output(/master.*->.*#{branch_name}/, all_output)
end

Then /^"([^"]*)" is added as a collaborator on my new pairzone$/ do |collaborator_name|
  look_for "Collaborator '#{collaborator_name}' added."
end

Then /^"([^"]*)" is not added as a collaborator on my new pairzone$/ do |collaborator_name|
  assert_no_partial_output("Collaborator '#{collaborator_name}' added.", all_output)
end

Then /^"([^"]*)" should be connected to "([^"]*)"$/ do |arg1, arg2|
  check_attempt_connect
end

Then /^"([^"]*)" should not be able to connect$/ do |collaborator_name|
  look_for "No pairzone exists"
end
