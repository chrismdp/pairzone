module PairzoneDSL
  def create_local_git_repository
    run "git init"
    run "echo foo >foo"
    run "git add ."
    run "git commit -m 'Initial commit'"
  end
end
World(PairzoneDSL)
