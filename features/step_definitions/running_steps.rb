def pairzone_command(command, identity = 'bob', interactive = false)
  pairzone, *args = command.split
  interactively = interactive ? " interactively" : ""
  When %{I run "#{pairzone} --debug --config=#{config_directory} --identity=../../features/keys/#{identity}.key #{args.join(' ')}"#{interactively}}
end

When /^"([^"]*)" runs? "([^"]*)" in test mode$/ do |developer_name, command|
  save_token(developer_name)
  pairzone_command(command, developer_name)
end

When /^"([^"]*)" runs "([^"]*)" in test mode with no api key$/ do |developer_name, command|
  pairzone_command(command, developer_name, true)
end

Given /^"([^"]*)" has already started a pairzone with "([^"]*)" as a collaborator$/ do |developer_name, collaborator_name|
  Given "I have a local git repository"
  pairzone_command("pairzone start --background -c #{collaborator_name}", developer_name)
end

Given /^"([^"]*)" has already started a pairzone$/ do |developer_name|
  Given "I have a local git repository"
  pairzone_command("pairzone start --background", developer_name)
end
