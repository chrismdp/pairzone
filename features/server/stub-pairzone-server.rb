require 'sinatra'
require 'json/add/rails'
require 'rack/contrib'

before do
  if (request.env["PATH_INFO"] != '/users/find_key')
    auth = Rack::Auth::Basic::Request.new(request.env)
    @key = auth.credentials.first
    halt 401 unless @key =~ /pairzone-test-api-key/
  end
end

use Rack::NestedParams

PAIRZONES = {
  'derek-aruba' => {
    :ip => '127.0.0.1',
    :name => 'derek-aruba',
    :owner => 'derek',
    :collaborators => ['dave', 'edward']
  }
}

USERS = {
  'pairzone-test-api-key-derek' => {
    :username => 'derek',
    :apikey => 'pairzone-test-api-key-derek'
  },
  'pairzone-test-api-key-bob' => {
    :username => 'bob',
    :apikey => 'pairzone-test-api-key-bob'
  }
}

def username
  USERS[@key][:username]
end

get '/pairzones/:name.json' do |name|
  pairzone = PAIRZONES[name]
  halt 404 if pairzone.nil?
  halt 404 unless pairzone[:owner] == username || pairzone[:collaborators].include?(username)
  pairzone.to_json
end

post '/pairzones' do
  params['pairzone']['collaborators'].delete('invalid_collaborator') if (params['pairzone']['collaborators'])
  pairzone = params['pairzone']
  pairzone['ip'] = '127.0.0.1'
  pairzone['owner'] = username
  pairzone['status'] = 'started'
  pairzone['name'] = username + '-' + pairzone['project_name']
  pairzone['collaborators'] ||= []
  PAIRZONES[pairzone['name']] = pairzone
  pairzone.to_json
end

get '/current_user' do
  USERS[@key].to_json
end

post '/users/find_key' do
  match = USERS.values.select do |user|
    user[:username] == params[:username]
  end
  halt 404 if match.empty?
  match.first.to_json
end

get /.*/ do
  "RECEIVED GET: #{request.url.inspect}"
end

post /.*/ do
  "RECEIVED POST: #{request.url.inspect} WITH: #{request.body.string}"
end
