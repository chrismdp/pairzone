module Pairzone
  class Pairzone
    include PairzoneConnection
    extend PairzoneLifecycle

    def to_str
      "<%= color('This Pairzone: #{name}', CYAN + BOLD) %>\nOwner:         #{owner}\nCollaborators: #{collaborators.join(', ')}"
    end
  end
end
