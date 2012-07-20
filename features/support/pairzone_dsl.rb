module PairzoneDSL
  def create_local_git_repository
    run "git init"
    run "echo foo >foo"
    run "git add ."
    run "git commit -m 'Initial commit'"
  end

  def look_for(text)
    assert_partial_output(text, all_output)
  end

  def check_attempt_connect
    # We cannot run the session, but if this shows up we tried to
    look_for "/usr/local/bin/pairzone-tmux.sh: No such file or directory"
  end

  def check_didnt_connect
    # We cannot run the session, but if this shows up we tried to
    assert_no_partial_output %{the output should not contain "pairzone-tmux"}
  end

  def check_pairzone_started_for(developer_name)
    look_for "Starting Pairzone for project 'aruba'..."
    look_for "Pairzone '#{developer_name}-aruba' started."
    look_for "Pairzone booted: ip address 127.0.0.1"
  end
end
World(PairzoneDSL)
