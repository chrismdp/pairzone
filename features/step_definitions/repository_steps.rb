def create_local_git_repository
  run "git init"
  run "echo foo >foo"
  run "git add ."
  run "git commit -m 'Initial commit'"
end
Given /^I have a local git repository$/ do
  create_local_git_repository
end
