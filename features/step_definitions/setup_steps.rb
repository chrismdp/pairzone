Given /^I have a local git repository$/ do
  create_local_git_repository
end

Given /^I have previously provided my ec2 credentials$/ do
  create_ec2_credentials
end
