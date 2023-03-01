# opensim-0.9.1.1/bin/OpenSim.db
# opensim-0.9.1.1/bin/griduser.db
# opensim-0.9.1.1/bin/inventory.db
# opensim-0.9.1.1/bin/auth.db
# opensim-0.9.1.1/bin/userprofiles.db
# opensim-0.9.1.1/bin/Asset.db
# opensim-0.9.1.1/bin/friends.db
# opensim-0.9.1.1/bin/avatars.db

require 'sqlite3'

db=SQLite3::Database.new("opensim-0.9.1.1/bin/userprofiles.db")

# Find a few rows
db.execute( "select * from UserAccounts" ) do |row|
  p row
end
