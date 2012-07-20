def pairzone_command(command, identity = 'bob', interactive = false)
  pairzone, *args = command.split
  cmd = "#{pairzone} --debug --config=#{config_directory} #{args.join(' ')}"
  interactive ? run_interactive(cmd) : run(cmd)
end

When /^"([^"]*)" runs? "([^"]*)" in test mode$/ do |developer_name, command|
  pairzone_command(command, developer_name)
end

When /^"([^"]*)" runs "([^"]*)" in test mode with no api key$/ do |developer_name, command|
  pairzone_command(command, developer_name, true)
end

Given /^"([^"]*)" has already started a pairzone with "([^"]*)" as a collaborator$/ do |developer_name, collaborator_name|
  create_local_git_repository
  pairzone_command("pairzone start --background -c #{collaborator_name}", developer_name)
end

Given /^"([^"]*)" has already started a pairzone$/ do |developer_name|
  create_local_git_repository
  pairzone_command("pairzone start --background", developer_name)
end
