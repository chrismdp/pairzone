def look_for(text)
  Then %{the output should contain "#{text}"}
end

Then /^a new pairzone is started for "([^"]*)"$/ do |developer_name|
  look_for "Starting Pairzone for project 'aruba'..."
  look_for "Pairzone '#{developer_name}-aruba' started."
  look_for "Pairzone booted: ip address 127.0.0.1"
end

Then /^no pairzone should be started$/ do
  And %{the output should not contain "started"}
end

Then /^a new pairzone is started for "([^"]*)" in the background$/ do |developer_name|
  Then %{a new pairzone is started for "#{developer_name}"}
  And %{the output should not contain "pairzone-tmux"} # We cannot run the session, but if this shows up we tried to
end

Then /^the code in my current directory is pushed to the server$/ do
  look_for "pushing local code to pairzone instance"
  look_for "master -> master (forced update)" # the git printout
end

Then /^an SSH connection is made to my new pairzone$/ do
  look_for "/usr/local/bin/pairzone-tmux.sh: No such file or directory" # We cannot run the session, but this will show we tried to
end

Then /^the code is downloaded to a "([^"]*)" branch when I quit the session$/ do |branch_name|
  Then %{the output should match /master.*->.*#{branch_name}/}
end

Then /^"([^"]*)" is added as a collaborator on my new pairzone$/ do |collaborator_name|
  look_for "Collaborator '#{collaborator_name}' added."
end

Then /^"([^"]*)" is not added as a collaborator on my new pairzone$/ do |collaborator_name|
  Then %{the output should not contain "Collaborator '#{collaborator_name}' added."}
end

Then /^"([^"]*)" should be connected to "([^"]*)"$/ do |arg1, arg2|
  look_for "/usr/local/bin/pairzone-tmux.sh: No such file or directory" # We cannot run the session, but this will show we tried to
end

Then /^"([^"]*)" should not be able to connect$/ do |collaborator_name|
  look_for "No pairzone exists"
end
