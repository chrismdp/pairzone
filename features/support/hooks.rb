Before("@api_server") do
  start_server
end

Before("@announce") do
  @show_web_server_output = true
end

Before('@derek') do
  create_api_account_for('derek')
end

Before('@bob') do
  create_api_account_for('bob')
end

Before('@jim') do
  create_api_account_for('jim')
end

After do
  stop_server
  @show_web_server_output = false
end
