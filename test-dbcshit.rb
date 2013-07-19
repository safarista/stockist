# gem install rdbi rdbi-driver-odbc
require "rdbi-driver-odbc"

dbh = RDBI.connect(
  :ODBC,
  :db       => "fashion3",
  :username => "Admin",
  :password => "DBAdmin"
  )

rs = dbh.execute("SELECT * FROM BRANCHES LIMIT 1")
rs.as(:Struct).fetch(:first)
