namespace :util do

  require 'csv'

  desc "Create 100 contacts"

  task load_contacts: :environment do
    CSV.foreach("lib/tasks/users.csv", :headers => true) do |row|
      Contact.find_or_create_by!(:first_name => row['first_name'],
                                :last_name => row['last_name'],
                                :email => row['email'],
      )
    end

  end

end
