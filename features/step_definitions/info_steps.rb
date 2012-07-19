Then /^he sees information about his pairzone account$/ do
  Then %{the output should contain "Pairzone Account Information"}
  And %{the output should contain "Username:      derek"}
end

