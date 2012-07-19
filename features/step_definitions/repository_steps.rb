Given /^I have a local git repository$/ do
  Given 'I run "git init"'
  Given 'I run "echo foo >foo"'
  Given 'I run "git add ."'
  Given %{I run "git commit -m 'Initial commit'"}
end
