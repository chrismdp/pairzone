require 'background_process'

module ServerHelper
  SERVER_PATH = "#{File.dirname(__FILE__)}/../../../../pairzone-web"
  def server(command)
    wrapped = "bash -lc 'cd #{SERVER_PATH} && BUNDLE_GEMFILE=#{SERVER_PATH}/Gemfile && #{command}'"
    BackgroundProcess.run(wrapped)
  end

  def start_server
    @server = server("rails s -e smoke -p 54101")
    @server.detect {|line| out << line; line =~ /WEBrick::HTTPServer#start/ }
  end

  def out
    @out ||= []
  end

  def stop_server
    if (@server && @server.running?)
      # only reliable way I've found to kill it, as it's in a subshell
      `ps ax | grep "rails s -e smoke -p 54101" | grep -v bash | grep -v grep | cut -d' ' -f 1 | xargs kill -s INT`
      @server.wait
      out << @server.stdout.read
      out << @server.stderr.read
    end
    puts "\nTest server output:\n" + out.join if @show_web_server_output
  end

  def create_api_account_for(developer_name)
    @rake = server("RAILS_ENV=smoke rake db:reset db:setup pairzone:test:clear_users pairzone:test:add_user[#{developer_name},#{developer_name}_password]")
    @rake.wait
    out << @rake.stderr.read
    key = @rake.stdout.read.split.last.strip
    out << "Created api account for #{developer_name}. Key: #{key}\n\n"
    tokens[developer_name] = key
  end
end

World(ServerHelper)
