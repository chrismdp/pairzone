When /^"([^"]*)" supplies his credentials$/ do |developer_name|
  When %{I type "#{developer_name}@example.com"}
  And %{I type "#{developer_name}_password"}
end

Then /^his API key is saved$/ do
  Then %{the file "#{config_directory}/authentication_token" should contain "#{@apikey}"}
end
