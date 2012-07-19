module Pairzone
  module Api
    class Pairzone < Base
      include PairzoneConnection
      extend PairzoneLifecycle

      attr :identity

      property :name
      property :owner
      property :collaborators
      property :ip
      property :project_name
      property :status

      connect :find_by_project_name, :get => '/pairzones/:name.json', :with => :name, :on => :class, :rescue => { 'ResourceNotFound' => nil }

      connect :create, :post => '/pairzones', :with => :pairzone, :on => :class

      def to_str
        "<%= color('This Pairzone: #{name}', CYAN + BOLD) %>\nOwner:         #{owner}\nCollaborators: #{collaborators.join(', ')}"
      end
    end
  end
end
